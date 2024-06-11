extends AnimatedSprite2D

class_name PlayerVFX

enum PlayerAnimation {
	IDLE,
	SLASH,
	THRUST,
	DEATH
}

var current_animation: PlayerAnimation = PlayerAnimation.IDLE

func _ready():
	play_animation(PlayerAnimation.IDLE)

func play_animation(animation: PlayerAnimation):
	match animation:
		PlayerAnimation.IDLE:
			play("idle")
		PlayerAnimation.SLASH:
			play("slash")
		PlayerAnimation.THRUST:
			play("thrust")
		PlayerAnimation.DEATH:
			play("death")

func set_animation_state(state: String):
	match state:
		"idle":
			current_animation = PlayerAnimation.IDLE
			play_animation(current_animation)
		"slash":
			current_animation = PlayerAnimation.SLASH
			play_animation(current_animation)
		"thrust":
			current_animation = PlayerAnimation.THRUST
			play_animation(current_animation)
		"death":
			current_animation = PlayerAnimation.DEATH
			play_animation(current_animation)
		_:
			pass
			
func _on_animation_finished():
	if current_animation == PlayerAnimation.SLASH or current_animation == PlayerAnimation.THRUST:
		set_animation_state("idle")
