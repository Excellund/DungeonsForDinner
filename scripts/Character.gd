extends Node2D

class_name Character

enum CharacterType {
	HUMANOID,
	AMORPHOUS,
	PLANT,
	CONSTRUCT
}

var character_name: String
var health: int
var max_health: int
var is_dead: bool
var type: CharacterType
var nourishments: Array[Nourishment]

func _init(character_name, health, max_health, type):
	self.character_name = character_name
	self.health = health
	self.max_health = max_health
	self.is_dead = false
	self.type = type
	self.nourishments = []

func take_damage(amount: int):
	SignalBus.about_to_take_damage.emit(self)
	self.health = max(health - amount, 0)
	SignalBus.health_changed.emit(self, self.health)
	if health <= 0:
		die()
	
func heal(amount: int):
	self.health = min(health + amount, max_health)
	SignalBus.health_changed.emit(self, self.health)
	
func attack(_target: Character):
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
	SignalBus.character_dead.emit(self)
