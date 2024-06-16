extends EnemyCharacter

class_name MushroomCharacter

const NAME = "Mushroom"
const STARTING_HEALTH_MAX = 34
const STARTING_HEALTH_MIN = 26
const DAMAGE = 7

func _init():
	var starting_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	super._init(NAME, starting_health, starting_health, CharacterType.PLANT)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
