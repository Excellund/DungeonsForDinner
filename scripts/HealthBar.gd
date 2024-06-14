extends ProgressBar

class_name HealthBar

@onready var damage_bar = $"Damage Bar"
@onready var timer = $Timer
@onready var label = $Label

func setup_health(character: Character):
	character.health_changed.connect(self._on_health_changed)
	max_value = character.max_health
	value = character.health
	damage_bar.max_value = max_value
	damage_bar.value = value
	label.text = character.character_name

func _on_health_changed(new_health: int):
	var prev_health = value
	value = new_health
	
	if value < prev_health:
		timer.start()
	else:
		damage_bar.value = value

func _on_timer_timeout():
	damage_bar.value = value
