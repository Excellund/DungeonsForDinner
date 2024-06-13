extends Entity

class_name Slime

@onready var animations = $AnimatedSprite2D

func _on_area_clicked():
	super._on_area_clicked()
	animations.set_animation_state("hurt")

func _on_character_dead():
	pass # Replace with function body.
