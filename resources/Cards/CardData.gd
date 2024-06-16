extends Resource

class_name CardData

@export_group("card data")
@export var texture: Texture
@export var card_name: String
@export var cost: int
@export var damage: int
@export var healing_on_eat: int
@export_enum("Player", "One Enemy", "All Enemies") var target: int
@export_flags("Effect 1:1","Effect 2:2", "Effect 3:4") var effect_mask = 0
@export_multiline var attack_text: String
@export_multiline var eat_text: String

func _init():
	pass

func card_trigger():
	""""
	player.health -= cost
	if card was played
		target(s).health -= damage (if dam is negitive you would heal)
		use effect mask to determin which effects happened and resolve those
	else if card was eaten
		target(s).health += healing_on_eat
		use eat effect mask to determin which effects happened and resolve those
	"""
