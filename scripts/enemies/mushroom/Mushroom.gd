extends Entity

class_name Mushroom

@onready var animations = $AnimatedSprite2D

func _on_area_clicked():
	super._on_area_clicked()
	animations.set_animation_state("hurt")
