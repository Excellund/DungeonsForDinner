extends EnemyCharacter

class_name GolemCharacter

const GRANITE_GORGE = preload("res://scenes/nourishments/granite_gorge.tscn")

const NAME = "Golem"
const STARTING_HEALTH_MAX = 42
const STARTING_HEALTH_MIN = 38
const DAMAGE = 10

func _init():
	var starting_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	super._init(NAME, starting_health, starting_health, CharacterType.CONSTRUCT)
	var instance = GRANITE_GORGE.instantiate()
	instance.character = self
	nourishments.append(instance)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
