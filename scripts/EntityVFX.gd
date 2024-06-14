extends AnimatedSprite2D

class_name EntityVFX

signal death_animation_finished

enum State {
	IDLE,
	HURT,
	DEATH
}

var current_animation = State.IDLE

func _ready():
	play_animation(State.IDLE)
	
func play_animation(animation):
	match animation:
		State.IDLE:
			play("idle")
		State.HURT:
			play("hurt", true)
		State.DEATH:
			play("death")

func set_animation_state(state: String):
	if current_animation == State.DEATH:
		return
	
	match state:
		"idle":
			current_animation = State.IDLE
			play_animation(current_animation)
		"hurt":
			stop()
			current_animation = State.HURT
			play_animation(current_animation)
		"death":
			current_animation = State.DEATH
			play_animation(current_animation)
		_:
			pass
			
func _on_animation_finished():
	if current_animation == State.HURT:
		set_animation_state("idle")
	if current_animation == State.DEATH:
		emit_signal("death_animation_finished")

func _on_character_dead():
	set_animation_state("death")
