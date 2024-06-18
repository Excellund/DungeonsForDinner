extends Node

class_name Nourishment

var character: Character
var nourishment_name: String
var is_permanent: bool
var amount: int

func _init(nourishment_name: String, is_permanent: bool, amount: int = 1):
	self.nourishment_name = nourishment_name
	self.is_permanent = is_permanent
	self.amount = amount

func act():
	pass
