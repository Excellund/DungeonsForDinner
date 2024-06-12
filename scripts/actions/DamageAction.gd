extends Action

class_name DamageAction

var amount: int
var target: Character

func _init(amount: int, target: Character):
	self.amount = amount
	self.target = target
	act()
	
func act():
	target.take_damage(amount)
