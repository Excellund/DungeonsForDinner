extends Node2D

class_name Character

var character_name: String
var health: int
var max_health: int
var is_dead: bool
var nourishments: Array[Nourishment]

signal health_changed(new_health: int)
signal dead

func _init(name, health, max_health):
	self.character_name = name
	self.health = health
	self.max_health = max_health
	self.nourishments = []

func take_damage(amount: int):
	self.health = max(health - amount, 0)
	emit_signal("health_changed", self.health)
	if health <= 0:
		die()
	
func heal(amount: int) -> void:
	self.health = min(health + amount, max_health)
	emit_signal("health_changed", self.health)
	
func attack(target: Character):
	pass
	
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
	is_dead = true
	emit_signal("dead")
