extends Node

class_name Character

var health: int
var max_health: int
var nourishments: Array[Nourishment]

func _init(health, max_health):
	self.health = health
	self.max_health = max_health
	self.nourishments = []

func take_damage(amount: int):
	self.health = max(health - amount, 0)
	
func heal(amount: int) -> void:
	self.health = min(health + amount, max_health)
	
func apply_nourishment(type: Nourishment, amount: int):
	for nourishment in self.nourishments:
		if nourishment.name == type.name:
			nourishment.amount += amount
			return

	nourishments.append({"type": type, "amount": amount})
	
func decrease_nourishments():
	for nourishment in self.nourishments:
		if not nourishment.is_permanent:
			nourishment.amount -= 1

func die():
	pass
