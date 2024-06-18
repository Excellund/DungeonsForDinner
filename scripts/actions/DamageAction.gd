extends Action

class_name DamageAction

var origin: Character
var target: Character
var amount: int

func _init(origin: Character, target: Character, amount: int, ):
	SignalBus.damage_increase.connect(_on_damage_increase)
	self.origin = origin
	self.target = target
	self.amount = amount
	SignalBus.damage_action.emit(self)
	act()
	
func act():
	target.take_damage(amount)



func _on_damage_increase(reference: Character, amount: int):
	if not reference == origin:
		return
	
	self.amount += amount
