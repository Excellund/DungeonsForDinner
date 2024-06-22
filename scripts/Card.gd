extends Control

class_name Card

@export_group("inner settings")
@export var card_updater: SubViewport
@export var card_sprite: Sprite2D
@export var rotation_speed: float = 0.0
@export_category("CardData")
@export var card_data: CardData

var attack_side_texture: ImageTexture
var eat_side_texture: ImageTexture

# vars for setting card text
var card_name: String

# vars for states
var is_dead: bool = false
var is_card_held: bool = false
var is_rotating: bool = false
var is_attack_side: bool = true
var is_tweening: bool = false
var entity_held_over: Entity = null

# vars for rotation lerp
var staring_angle: float = PI
var desired_angle: float = 0.01
const HALF_ANGLE: float = PI/2
var elapsed = 0
var drag_offset: Vector2

# vars for tweening
var pre_hover_rotation: float = 0
var pre_held_position: Vector2
const TWEEN_TRANS_SPEED: float = 1
const TWEEN_ROTATION_SPEED: float = 1
const TWEEN_HOVER_ROTATION_SPEED: float = 0.25

signal card_modified(is_attack_side_local: bool)


func _ready():
	self.set_card_data(card_data)
	self.card_modified.connect(_on_card_modified)


func _process(delta):
	if is_card_held:
		global_position = get_global_mouse_position() - drag_offset
	if is_rotating:
		elapsed = min(elapsed + (delta*rotation_speed), 1)
		var rot_y: float = rad_to_deg(lerp_angle(staring_angle, desired_angle, elapsed))
		card_sprite.material.set_shader_parameter("y_rot", rot_y)
		if is_equal_approx(desired_angle, deg_to_rad(rot_y)):
			elapsed = 0
			is_rotating = false
		elif 85 < rot_y and rot_y < 95:
			if is_attack_side:
				card_sprite.texture = attack_side_texture
			else:
				card_sprite.texture = eat_side_texture

func move_to_from(from_pos, target_pos, from_rot, target_rot):
	is_tweening = true
	pre_hover_rotation = target_rot
	
	var tween = create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED)\
	.from(from_pos).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_ROTATION_SPEED)\
	.from(from_rot).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.connect("finished", _on_tween_finished)
	
	return tween


func move_to_from_current(target_pos, target_rot):
	is_tweening = true
	pre_hover_rotation = target_rot
	
	var tween = create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED/3).from_current()\
	.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_HOVER_ROTATION_SPEED).from_current()
	tween.connect("finished", _on_tween_finished)
	
	return tween


func _on_mouse_entered():
	card_sprite.z_index = 10
	var tween = create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",0,TWEEN_HOVER_ROTATION_SPEED).from_current()
	tween.parallel().tween_property(card_sprite,"scale",Vector2(1.15,1.15),0.3).from_current().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_mouse_exited():
	card_sprite.z_index = 1
	var tween = create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",pre_hover_rotation,TWEEN_HOVER_ROTATION_SPEED).from_current()
	tween.parallel().tween_property(card_sprite,"scale",Vector2(1,1),0.3).from_current()


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
				SignalBus.card_used.emit(self, entity_held_over.duplicate(), is_attack_side)
			else:
				is_tweening = true
				var tween = create_tween()
				tween.parallel().tween_property(self,"global_position",pre_held_position,TWEEN_TRANS_SPEED)\
				.from_current().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
				tween.connect("finished", _on_tween_finished)
			
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		#check if RMB is pressed and we're nor currently rotating
		if event.button_mask & MOUSE_BUTTON_MASK_RIGHT and not is_rotating and not is_tweening:
			is_rotating = true
			is_attack_side = not is_attack_side
			var temp = desired_angle
			desired_angle = staring_angle
			staring_angle = temp


func set_card_data(data: CardData):
	self.card_data = data
	card_name = data.card_name
	
	var a_img: Image = await card_updater.get_flattened_sprite(self.card_data, true)
	attack_side_texture = ImageTexture.create_from_image(a_img)
	
	var b_img: Image = await card_updater.get_flattened_sprite(self.card_data, false)
	eat_side_texture = ImageTexture.create_from_image(b_img)
	
	if is_attack_side:
		self.card_sprite.texture = self.attack_side_texture
	else:
		self.card_sprite.texture = self.eat_side_texture

func _on_card_modified(is_attack_side_local: bool):
	if is_attack_side_local:
		var a_img: Image = await card_updater.get_flattened_sprite(self.card_data, true)
		attack_side_texture = ImageTexture.create_from_image(a_img)
		self.card_sprite.texture = self.attack_side_texture
	else:
		var b_img: Image = await card_updater.get_flattened_sprite(self.card_data, false)
		eat_side_texture = ImageTexture.create_from_image(b_img)
		self.card_sprite.texture = self.eat_side_texture


func _on_area_2d_area_entered(area: Area2D):
	if area.get_parent() is Entity:
		entity_held_over = area.get_parent()


func _on_area_2d_area_exited(_area):
	entity_held_over = null


func _on_tween_finished():
	is_tweening = false
