extends Character

class_name PlayerCharacter

const NAME = "Barbarian"
const STARTING_HEALTH: int = 50
const DAMAGE = 10

func _init():
	super._init(NAME, STARTING_HEALTH, STARTING_HEALTH, CharacterType.HUMANOID)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
