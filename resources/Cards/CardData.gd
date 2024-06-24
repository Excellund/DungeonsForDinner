extends Resource

class_name CardData

@export_group("card data")
@export var texture: Texture
@export var card_name: String
@export var cost: int
@export var healing_on_eat: int
@export_enum("Player", "One Enemy", "All Enemies", "Everyone") var card_target: String
@export var actions: Dictionary
@export var eat_actions: Dictionary = {"Servings": 1}
@export_group("text boxes")
@export_multiline var attack_text: String
@export_multiline var eat_text: String

func _init():
	pass
