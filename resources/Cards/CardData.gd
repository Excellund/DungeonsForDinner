extends Resource

class_name CardData

@export_group("card data")
@export var texture: Texture
@export var card_name: String
@export var cost: String
@export_multiline var attack_text: String
@export_multiline var eat_text: String

func _init():
	pass
