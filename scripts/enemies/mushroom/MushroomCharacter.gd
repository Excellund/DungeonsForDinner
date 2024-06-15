extends EnemyCharacter

class_name MushroomCharacter

const NAME = "Mushroom"
const STARTING_HEALTH_MAX = 34
const STARTING_HEALTH_MIN = 26
const DAMAGE = 7

func _init():
	self.character_name = NAME
	self.max_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	self.health = self.max_health

func attack(target: Character):
	DamageAction.new(DAMAGE, target)
