extends Resource

class_name CardData

@export_group("card data")
@export var texture: Texture
@export var card_name: String
@export var cost: int
@export var damage: int
@export var healing_on_eat: int
@export_enum("Player", "One Enemy", "All Enemies", "Everyone") var card_target: String
@export_flags("Effect 1:1","Effect 2:2", "Effect 3:4") var effect_mask = 0
@export var actions: Array
@export var eat_actions: Array
@export_multiline var attack_text: String
@export_multiline var eat_text: String

func _init():
	pass

func get_targets(tree: SceneTree):
	
	match card_target:
		"Player":
			return tree.get_nodes_in_group("Player")
		"All Enemies":
			return tree.get_nodes_in_group("Enemy")
		"Everyone":
			return tree.get_nodes_in_group("Player") + tree.get_nodes_in_group("Enemy")
		_:
			return []
		


func card_trigger(entity_target: Entity, is_attack_side: bool):
	if is_attack_side:
		var confirmed_targets : Array
		if card_target != "One Enemy":
			entity_target = get_targets(entity_target.get_tree())
		else:
			confirmed_targets = [entity_target]
		
		for target in confirmed_targets:
			pass
	else:
		var player = entity_target.get_tree().get_nodes_in_group("Player")[0]
		player.heal(healing_on_eat)
		for i in range(0, eat_actions.size(), 2):
			eat_actions[i].new()
		
	""""
	player.health -= cost
	if card was played
		target(s).health -= damage (if dam is negitive you would heal)
		use effect mask to determin which effects happened and resolve those
	else if card was eaten
		target(s).health += healing_on_eat
		use eat effect mask to determin which effects happened and resolve those
	"""
