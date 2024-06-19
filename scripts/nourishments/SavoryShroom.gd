extends Nourishment

class_name SavoryShroom

const REGEN_FACTOR = 0.2

func _init(nourishment_name: String = "Savory Shroom", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	SignalBus.end_of_turn.connect(act)
	SignalBus.update_info_box_description.emit(self.info_box, "At end of your turn, gain " + str(REGEN_FACTOR * 100) + "% of max health")

func act():
	var health_gained = REGEN_FACTOR * character.max_health
	HealAction.new(health_gained, character)
