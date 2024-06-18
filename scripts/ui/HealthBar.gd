extends ProgressBar

class_name HealthBar

@export var damage_bar: ProgressBar
@export var timer: Timer
@export var name_label: Label
@export var health_label: Label

var character: Character

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	SignalBus.max_health_changed.connect(_on_max_health_changed)
	SignalBus.health_changed.connect(_on_health_changed)

func setup_health(character: Character):
	self.character = character
	max_value = character.max_health
	value = character.health
	damage_bar.max_value = max_value
	damage_bar.value = value
	name_label.text = character.character_name
	update_health_label()

func update_health_label():
	health_label.text = str(character.health) + "/" + str(character.max_health)

func _on_max_health_changed(reference: Character, _new_max_health: int):
	if not reference == character:
		return
	
	setup_health(character)

func _on_health_changed(reference: Character, new_health: int):
	if not reference == character:
		return
	
	var prev_health = value
	value = new_health
	update_health_label()
	
	if value < prev_health:
		timer.start()
	else:
		damage_bar.value = value

func _on_timer_timeout():
	damage_bar.value = value
