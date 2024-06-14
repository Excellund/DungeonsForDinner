extends EntityVFX

class_name PlayerVFX

enum PlayerAnimation {
	SLASH = 3,
	THRUST = 4
}

func play_animation(animation):
	super.play_animation(animation)
	match animation:
		PlayerAnimation.SLASH:
			play("slash")
		PlayerAnimation.THRUST:
			play("thrust")

func set_animation_state(state: String):
	super.set_animation_state(state)
	match state:
		"slash":
			stop()
			current_animation = PlayerAnimation.SLASH
			play_animation(current_animation)
		"thrust":
			stop()
			current_animation = PlayerAnimation.THRUST
			play_animation(current_animation)
		_:
			pass
			
func _on_animation_finished():
	if current_animation == PlayerAnimation.SLASH or current_animation == PlayerAnimation.THRUST:
		set_animation_state("idle")
