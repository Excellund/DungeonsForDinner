extends Entity

class_name Player

@onready var animations = $AnimatedSprite2D

func _input(event):
	if event.is_action_pressed("left_click"):
		animations.set_animation_state("slash")
	elif event.is_action_pressed("right_click"):
		animations.set_animation_state("thrust")

func _on_enemy_clicked(target: Character):
	DamageAction.new(5, target)
