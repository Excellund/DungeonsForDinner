extends Nourishment

class_name GraniteGorge

const BATTLE_BITE = preload("res://scenes/nourishments/battle_bite.tscn")

const HEALTH_THRESHOLD_FACTOR = 0.5
const HEALTH_INCREASE_FACTOR = 2
const BATTLE_BITE_GAINED = 3

var is_triggered: bool = false

func _init(nourishment_name: String = "Granite Gorge", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	SignalBus.health_changed.connect(_on_health_changed)
	
func update_info_box():
	super.update_info_box()
	info_box.description.text = "At half health, double max health and current health. \nGain " + str(BATTLE_BITE_GAINED) + " Battle Bite."
	
func _on_health_changed(reference: Character, health: int):
	if not reference == character:
		return
	if is_triggered:
		return
	if health > character.max_health * HEALTH_THRESHOLD_FACTOR:
		return

	is_triggered = true
	character.max_health *= HEALTH_INCREASE_FACTOR
	SignalBus.max_health_changed.emit(character, character.max_health)
	character.health *= HEALTH_INCREASE_FACTOR
	SignalBus.health_changed.emit(character, character.health)
	var nourishment = BATTLE_BITE.instantiate()
	nourishment.character = character
	ApplyNourishmentAction.new(character, nourishment, BATTLE_BITE_GAINED)
