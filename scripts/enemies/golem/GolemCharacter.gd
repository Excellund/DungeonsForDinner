extends EnemyCharacter

class_name GolemCharacter

const NAME = "Golem"
const STARTING_HEALTH_MAX = 42
const STARTING_HEALTH_MIN = 38

func _init():
	self.name = NAME
	self.health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
