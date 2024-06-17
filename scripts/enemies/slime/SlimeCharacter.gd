extends EnemyCharacter

class_name SlimeCharacter

const SLIME_SAUCE = preload("res://scenes/nourishments/slime_sauce.tscn")

const NAME = "Slime"
const STARTING_HEALTH_MAX = 25
const STARTING_HEALTH_MIN = 18
const DAMAGE = 5

func _init():
	var starting_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	super._init(NAME, starting_health, starting_health, CharacterType.AMORPHOUS)
	var instance: Nourishment = SLIME_SAUCE.instantiate()
	instance.character = self
	nourishments.append(instance)

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
