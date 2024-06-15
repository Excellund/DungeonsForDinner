extends EntityVFX

class_name SlimeVFX

var is_attack_reversed: bool = false

func play_animation(animation):
	match animation:
		State.IDLE:
			play("idle")
		State.HURT:
			play("hurt", true)
		State.ATTACK:
			flip_h = true
			play("attack", true)
		State.DEATH:
			play("death")

func _on_animation_finished():
	match current_animation:
		State.HURT:
			set_animation_state("idle")
		State.ATTACK:
			if is_attack_reversed:
				flip_h = false
				set_animation_state("idle")
				is_attack_reversed = false
			else: 
				play_backwards("attack")
				is_attack_reversed = true
		State.DEATH:
			emit_signal("death_animation_finished")
