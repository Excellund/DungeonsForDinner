extends Nourishment

class_name SavoryShroom

const REGEN_FACTOR = 0.2

func _init(nourishment_name: String = "Savory Shroom", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	
func _ready():
	SignalBus.end_of_turn.connect(act)

func act():
	var health_gained = REGEN_FACTOR * character.max_health
	HealAction.new(health_gained, character)
