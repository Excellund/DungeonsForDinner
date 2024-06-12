extends Character

class_name PlayerCharacter

const NAME = "Barbarian"
const STARTING_HEALTH: int = 50

func _init():
	super._init(NAME, STARTING_HEALTH, STARTING_HEALTH)
