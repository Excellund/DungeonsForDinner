extends Action

class_name ApplyNourishmentAction

var target: Character
var nourishment: Nourishment
var amount: int

func _init(target: Character, nourishment: Nourishment, amount: int):
	self.target = target
	self.nourishment = nourishment
	self.amount = amount
	act()

func act():
	target.apply_nourishment(nourishment, amount)
	SignalBus.nourishment_applied.emit(target, nourishment)
