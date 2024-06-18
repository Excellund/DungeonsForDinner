extends EntityVFX

class_name PlayerVFX

enum PlayerAnimation {
	THRUST = 4
}

func play_animation(new_animation):
	super.play_animation(new_animation)
	match new_animation:
		State.HURT:
			set_animation_state("idle")
		PlayerAnimation.THRUST:
			play("thrust")

func set_animation_state(state: String):
	super.set_animation_state(state)
	match state:
		"thrust":
			stop()
			current_animation = PlayerAnimation.THRUST
			play_animation(current_animation)
		_:
			pass
			
func _on_animation_finished():
	super._on_animation_finished()
	if current_animation == PlayerAnimation.THRUST:
		set_animation_state("idle")
