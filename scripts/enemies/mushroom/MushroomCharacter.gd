extends EnemyCharacter

class_name MushroomCharacter

const SAVORY_SHROOM = preload("res://scenes/nourishments/savory_shroom.tscn")

const NAME = "Mushroom"
const STARTING_HEALTH_MAX = 34
const STARTING_HEALTH_MIN = 26
const DAMAGE = 7

func _init():
	var starting_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	super._init(NAME, starting_health, starting_health, CharacterType.PLANT)
	var instance = SAVORY_SHROOM.instantiate()
	instance.character = self
	nourishments.append(instance)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
