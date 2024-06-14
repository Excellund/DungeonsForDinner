extends EnemyCharacter

class_name SlimeCharacter

const NAME = "Slime"
const STARTING_HEALTH_MAX = 25
const STARTING_HEALTH_MIN = 18

func _init():
	self.character_name = NAME
	self.max_health = randi_range(STARTING_HEALTH_MIN, STARTING_HEALTH_MAX)
	self.health = self.max_health
