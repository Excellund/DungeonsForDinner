extends Nourishment

class_name BattleBite

func _init(nourishment_name: String = "Battle Bite", is_permanent: bool = true, amount: int = 1):
	super._init(nourishment_name, is_permanent, amount)

func _ready():
	SignalBus.damage_action.connect(_on_damage_action)

func _on_damage_action(reference: DamageAction):
	if not reference.origin.nourishments.has(self):
		return
	
	SignalBus.damage_increase.emit(reference.origin, amount)
