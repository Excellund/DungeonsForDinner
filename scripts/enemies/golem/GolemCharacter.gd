extends EnemyCharacter

class_name GolemCharacter

const NAME = "Golem"
const STARTING_HEALTH_MAX = 42
const STARTING_HEALTH_MIN = 38
const DAMAGE = 10

func _init():
	var starting_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	super._init(NAME, starting_health, starting_health, CharacterType.CONSTRUCT)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
