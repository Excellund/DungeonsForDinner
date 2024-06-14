extends Entity

class_name Player

func _input(event):
	if event.is_action_pressed("left_click"):
		vfx.set_animation_state("slash")
	elif event.is_action_pressed("right_click"):
		vfx.set_animation_state("thrust")

func _on_enemy_clicked(target: Character):
	DamageAction.new(10, target)
