extends Entity

class_name Slime

@onready var animations = $AnimatedSprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
				animations.set_animation_state("hurt")
