extends Control

class_name Card

@export_group("inner settings")
@export var card_sprite: Sprite2D
@export var rotation_speed: float = 0.0
@export_category("CardData")
@export var card_data: CardData

var attack_side_texture: ImageTexture
var eat_side_texture: ImageTexture

# vars for setting card text
var card_name: String
var cost: int
var attack_text: String
var eat_text: String
var card_target: String

# vars for states
var is_card_held: bool = false
var is_rotating: bool = false
var is_attack_side: bool = true
var is_tweening: bool = false
var entity_held_over: Entity = null

# vars for rotation lerp
var staring_angle: float = 0
var desired_angle: float = -PI
var cur_desired_angle: float = PI/2
const A_SIDE_ANGLE: float = 0
const B_SIDE_ANGLE: float = -PI
const HALF_ANGLE: float = PI/2
var elapsed = 0
var drag_offset: Vector2

# vars for tweening
var pre_hover_rotation: float = 0
var pre_held_position: Vector2
const TWEEN_TRANS_SPEED: float = 1
const TWEEN_ROTATION_SPEED: float = 1
const TWEEN_HOVER_ROTATION_SPEED: float = 0.25


func _ready():
	var a_img: Image = await AllCardUpdater.get_flattened_sprite(card_data, true)
	attack_side_texture = ImageTexture.create_from_image(a_img)
	
	var b_img: Image = await AllCardUpdater.get_flattened_sprite(card_data, false)
	eat_side_texture = ImageTexture.create_from_image(b_img)
	card_sprite.texture = attack_side_texture
	

func _process(delta):
	if is_card_held:
		global_position = get_global_mouse_position() - drag_offset
	if is_rotating:
		elapsed = min(elapsed + (delta*rotation_speed), 1)
		var rot_y: float = rad_to_deg(lerp_angle(staring_angle, cur_desired_angle, elapsed))
		card_sprite.material.set_shader_parameter("y_rot", rot_y)

		if is_equal_approx(desired_angle, deg_to_rad(rot_y)):
			is_rotating = false
			elapsed = 0
			if is_attack_side:
				cur_desired_angle = HALF_ANGLE
				staring_angle = A_SIDE_ANGLE
				desired_angle = B_SIDE_ANGLE
			else:
				cur_desired_angle = -HALF_ANGLE
				staring_angle = B_SIDE_ANGLE
				desired_angle = A_SIDE_ANGLE

		elif is_equal_approx(cur_desired_angle, deg_to_rad(rot_y)):
			cur_desired_angle = desired_angle
			elapsed = 0
			
			if is_attack_side:
				staring_angle = HALF_ANGLE
				card_sprite.texture = attack_side_texture
				card_sprite.scale = Vector2(1,1)
			else:
				staring_angle = -HALF_ANGLE
				card_sprite.texture = eat_side_texture
				card_sprite.scale = Vector2(-1,1)

func move_to_from(from_pos, target_pos, from_rot, target_rot):
	is_tweening = true
	pre_hover_rotation = target_rot
	
	var tween = get_tree().create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED)\
	.from(from_pos).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_ROTATION_SPEED)\
	.from(from_rot).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.connect("finished", _on_tween_finished)
	
	return tween


func move_to_from_current(target_pos, target_rot):
	is_tweening = true
	pre_hover_rotation = target_rot
	
	var tween = get_tree().create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED/3).from_current()\
	.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_HOVER_ROTATION_SPEED).from_current()
	tween.connect("finished", _on_tween_finished)
	
	return tween


func _on_mouse_entered():
	card_sprite.z_index = 10
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",0,TWEEN_HOVER_ROTATION_SPEED).from_current()
	if is_attack_side:
		tween.parallel().tween_property(card_sprite,"scale",Vector2(1.15,1.15),0.3).from_current().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	else:
		tween.parallel().tween_property(card_sprite,"scale",Vector2(-1.15,1.15),0.3).from_current().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_mouse_exited():
	card_sprite.z_index = 1
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",pre_hover_rotation,TWEEN_HOVER_ROTATION_SPEED).from_current()
	if is_attack_side:
		tween.parallel().tween_property(card_sprite,"scale",Vector2(1,1),0.3).from_current()
	else:
		tween.parallel().tween_property(card_sprite,"scale",Vector2(-1,1),0.3).from_current()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check if LMB is pressed and allow the card to be moved
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT and not is_tweening:
			pre_held_position = self.global_position 
			is_card_held = true
			# set offset so card is dragged from where the user clicked
			drag_offset = get_global_mouse_position() - global_position
		# check if LMB is relesed and stop the card from moving
		elif is_card_held:
			is_card_held = false
			
			if entity_held_over:
				SignalBus.card_used.emit(self, entity_held_over, is_attack_side)
			else:
				is_tweening = true
				var tween = get_tree().create_tween()
				tween.parallel().tween_property(self,"global_position",pre_held_position,TWEEN_TRANS_SPEED)\
				.from_current().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
				tween.connect("finished", _on_tween_finished)
			
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		#check if RMB is pressed and we're nor currently rotating
		if event.button_mask & MOUSE_BUTTON_MASK_RIGHT and not is_rotating:
			is_rotating = true
			is_attack_side = not is_attack_side


func set_card_data(data: CardData):
	card_data = data
	#card_sprite.texture = data.texture
	card_name = data.card_name
	#cost = data.cost
	#card_target = data.target
	#attack_text = data.attack_text
	#eat_text = data.eat_text


func _on_area_2d_area_entered(area: Area2D):
	entity_held_over = area.get_parent()


func _on_area_2d_area_exited(_area):
	entity_held_over = null


func _on_tween_finished():
	is_tweening = false


func _on_button_pressed():
	card_data.cost += 1
	var a_img: Image = await AllCardUpdater.get_flattened_sprite(card_data, true)
	attack_side_texture = ImageTexture.create_from_image(a_img)
	if is_attack_side:
		card_sprite.texture = attack_side_texture
