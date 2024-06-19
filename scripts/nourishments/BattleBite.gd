extends Nourishment

class_name BattleBite

func _init(nourishment_name: String = "Battle Bite", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)
	SignalBus.damage_action.connect(_on_damage_action)
	
func update_info_box():
	super.update_info_box()
	info_box.description.text = "Increases damage by " + str(amount) + "."

func _on_damage_action(reference: DamageAction):
	if not reference.origin.nourishments.has(self):
		return
	
	SignalBus.damage_increase.emit(reference.origin, amount)
