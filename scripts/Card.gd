extends Container

class_name Card


@export var card_data: CardData: set = set_card_data

@export var card_sprite: Sprite2D
@export var rotation_speed: float = 0.0

var card_name: String
var is_card_held: bool = false
var is_rotating: bool = false
var staring_angle: float = PI
var desired_angle: float = 0.01
var elapsed = 0
var drag_offset: Vector2


func _init(data):
	card_data = data


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


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check if LMB is pressed and allow the card to be moved
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			is_card_held = true
			# set offset so card is dragged from where the user clicked
			drag_offset = get_global_mouse_position() - global_position
		# check if LMB is relesed and stop the card from moving
		else:
			is_card_held = false
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		#check if RMB is pressed and we're nor currently rotating
		if event.button_mask & MOUSE_BUTTON_MASK_RIGHT and not is_rotating:
			var temp = desired_angle
			desired_angle = staring_angle
			staring_angle = temp
			is_rotating = true


func set_card_data(data: CardData):
	card_sprite.texture = data.texture
	card_name = data.card_name
	#the others
