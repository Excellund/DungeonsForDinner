extends Node2D

const BUTTON_LEFT = 1
const BUTTON_RIGHT = 2

@onready var animations = $AnimatedSprite2D

func _input(event):
	if event is InputEventMouseButton:
		var mouse_button = event.button_index
		if event.pressed:
			if mouse_button == BUTTON_LEFT:
				animations.set_animation_state("slash")
			elif mouse_button == BUTTON_RIGHT:
				animations.set_animation_state("thrust")
