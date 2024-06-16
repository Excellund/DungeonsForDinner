class_name Nourishment

var name: String
var is_permanent: bool
var amount: int

func _init(name: String, is_permanent: bool, amount: int = 1):
	self.name = name
	self.is_permanent = is_permanent
	self.amount = amount

func act():
	pass
