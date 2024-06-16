extends ProgressBar

class_name HealthBar

@export var damage_bar: ProgressBar
@export var timer: Timer
@export var label: Label

var character: Character

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func setup_health(character: Character):
	self.character = character
	SignalBus.health_changed.connect(_on_health_changed)
	max_value = character.max_health
	value = character.health
	damage_bar.max_value = max_value
	damage_bar.value = value
	label.text = character.character_name

func _on_health_changed(reference: Character, new_health: int):
	if not reference == character:
		return
	
	var prev_health = value
	value = new_health
	
	if value < prev_health:
		timer.start()
	else:
		damage_bar.value = value

func _on_timer_timeout():
	damage_bar.value = value
