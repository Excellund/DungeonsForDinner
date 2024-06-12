extends EnemyCharacter

class_name SlimeCharacter

const NAME = "Slime"
const STARTING_HEALTH_MAX = 25
const STARTING_HEALTH_MIN = 18

func _init():
	self.name = NAME
	self.health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
