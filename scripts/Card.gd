extends Container

class_name Card

signal card_used(card_data: CardData, is_attack_side: bool)

@export_group("inner settings")
@export var card_sprite: Sprite2D
@export var animator: AnimationPlayer
@export var rotation_speed: float = 0.0
@export_category("CardData")
@export var card_data: CardData: set = set_card_data

var card_name: String
# vars for states
var is_card_held: bool = false
var is_rotating: bool = false
var is_attack_side: bool = true
# vars for rotation lerp
var staring_angle: float = PI
var desired_angle: float = 0.01
var elapsed = 0
var drag_offset: Vector2
# vars for tweening
var pre_hover_rotation: float = 0
var pre_held_position: Vector2
const TWEEN_TRANS_SPEED: float = 1
const TWEEN_ROTATION_SPEED: float = 1
const TWEEN_HOVER_ROTATION_SPEED: float = 0.25


func _process(delta):
	if is_card_held:
		global_position = get_global_mouse_position() - drag_offset
	if is_rotating:
		elapsed = min(elapsed + (delta*rotation_speed), 1)
		var rot_y: float = rad_to_deg(lerp_angle(staring_angle, desired_angle, elapsed))
		card_sprite.material.set_shader_parameter("y_rot", rot_y)
		if is_equal_approx(card_sprite.material.get_shader_parameter("y_rot"), rad_to_deg(desired_angle)):
			is_rotating = false
			elapsed = 0


func move_to_from(from_pos, target_pos, from_rot, target_rot):
	pre_hover_rotation = target_rot
	print(from_pos, target_pos, from_rot," ", target_rot)
	var tween = get_tree().create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED)\
	.from(from_pos).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_ROTATION_SPEED)\
	.from(from_rot).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	return tween


func move_to_from_current(target_pos, target_rot):
	pre_hover_rotation = target_rot
	var tween = get_tree().create_tween()
	
	tween.parallel().tween_property(self,"global_position",target_pos,TWEEN_TRANS_SPEED).from_current()
	tween.parallel().tween_property(card_sprite,"rotation",target_rot,TWEEN_HOVER_ROTATION_SPEED).from_current()
	
	return tween


func _on_mouse_entered():
	card_sprite.z_index = 10
	animator.play("Hover")
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",0,TWEEN_HOVER_ROTATION_SPEED).from_current()


func _on_mouse_exited():
	card_sprite.z_index = 1
	animator.play("Unhover")
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(card_sprite,"rotation",pre_hover_rotation,TWEEN_HOVER_ROTATION_SPEED).from_current()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check if LMB is pressed and allow the card to be moved
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			pre_held_position = self.global_position 
			is_card_held = true
			# set offset so card is dragged from where the user clicked
			drag_offset = get_global_mouse_position() - global_position
		# check if LMB is relesed and stop the card from moving
		else:
			is_card_held = false
			card_used.emit(self.card_data, is_attack_side)
			#await no_target
			
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		#check if RMB is pressed and we're nor currently rotating
		if event.button_mask & MOUSE_BUTTON_MASK_RIGHT and not is_rotating:
			var temp = desired_angle
			desired_angle = staring_angle
			staring_angle = temp
			is_rotating = true
			is_attack_side = not is_attack_side


func set_card_data(data: CardData):
	card_sprite.texture = data.texture
	card_name = data.card_name
	#the others
