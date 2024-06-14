extends Entity

class_name Golem

func _on_area_clicked():
	super._on_area_clicked()
	vfx.set_animation_state("hurt")
