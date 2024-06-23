extends Node2D

class_name GameManager

@export var player: Player
@export var end_turn_button: Button
@export var timer: Timer

var encounter: Encounter 
var enemies: Array[Entity] = []
var rock_salt_count: int = 0

func _ready():
	end_turn_button.text = "End Turn"
	end_turn_button.pressed.connect(self._on_end_turn_button_pressed)
	timer.timeout.connect(self._on_timer_timeout)
	SignalBus.death_animation_finished.connect(_on_entity_death)
	SignalBus.card_used.connect(_on_card_used)
	next_encounter()

func setup_encounter(new_encounter: Encounter):
	for enemy in enemies:
		enemy.queue_free()
	
	encounter = new_encounter
	enemies.clear()

	for i in range(encounter.enemies.size()):
		var enemy_instance: Entity = encounter.enemies[i].instantiate()
		enemy_instance.position = encounter.locations[i]
		enemies.append(enemy_instance)
		add_child(enemy_instance)
	
func next_encounter():
	setup_encounter(_EncounterManager.get_random_encounter())
	
func _on_entity_death(_reference: EntityVFX):
	for enemy: Entity in enemies:
		if not enemy.character.is_dead:
			return
	
	SignalBus.end_of_encounter.emit(encounter)
	#next_encounter()
	
func _on_end_turn_button_pressed():
	TurnManager.change_turn()
	end_turn_button.text = "Enemy Turn"
	end_turn_button.disabled = true
	for enemy in enemies:
		enemy.attack(player)
	timer.start()
	
func _on_timer_timeout():
	TurnManager.change_turn()
	end_turn_button.text = "End Turn"
	end_turn_button.disabled = false


func _on_card_used(card: Card, target: Entity, is_attack_side: bool):
	var card_data = card.card_data
	if is_attack_side:
		DamageAction.new(player.character, player.character, card_data.cost)
		var actions_dict = card_data.actions
		for action in actions_dict:
			match action:
				"Damage":
					DamageAction.new(player.character, target.character, actions_dict["Damage"])
				"RockSalt":
					DamageAction.new(player.character, target.character, 5 * rock_salt_count)
				_:
					pass
	else:
		var eat_actions_dict = card_data.eat_actions
		for action in card_data.eat_actions:
			match action:
				"Heal":
					HealAction.new(eat_actions_dict["Heal"], player.character)
				"Servings":
					ServingsAction.new(card)
				"RockSalt":
					rock_salt_count += 1
				"AddCard":
					SignalBus.add_card_action.emit(eat_actions_dict["AddCard"], "Hand", false)
				"AddCardPerm":
					SignalBus.add_card_action.emit(eat_actions_dict["AddCard"], "Hand", true)
				_:
					pass
	SignalBus.card_effect_resolved.emit(card)
