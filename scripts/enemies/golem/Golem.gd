extends Entity

class_name Golem

@onready var animations = $VFX

func _on_area_clicked():
	super._on_area_clicked()
	animations.set_animation_state("hurt")
