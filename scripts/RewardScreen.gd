extends CanvasLayer


@export_group("base card rewards")
@export var low_tier_rewards: Array[CardData]

@export_group("cards")
@export var left_card: Card
@export var mid_card: Card
@export var right_card: Card

var is_card_selected = false


func _ready():
	SignalBus.end_of_encounter.connect(_on_end_of_encounter)


func set_up_reward_screen(rewards: Array[CardData], reward_tier: int):
	self.get_tree().paused = true
	is_card_selected = false
	var possible_rewards: Array[CardData] = rewards + low_tier_rewards
	print(possible_rewards)
	possible_rewards.shuffle()
	self.left_card.set_card_data(possible_rewards[0])
	self.mid_card.set_card_data(possible_rewards[1])
	self.right_card.set_card_data(possible_rewards[2])
	self.visible = true


func _on_end_of_encounter(encounter: Encounter):
	set_up_reward_screen(encounter.rewards, 1)


func _on_left_button_pressed():
	_select_card(left_card)
		


func _on_mid_button_pressed():
	_select_card(mid_card)
	


func _on_right_button_pressed():
	_select_card(right_card)
		

func _select_card(selected_card: Card):
	if not is_card_selected:
		is_card_selected = true
		SignalBus.request_add_card_to_perm_deck.emit(selected_card.card_data.duplicate())
		var tween = selected_card.move_to_from_current(Vector2(1920,1080), PI/2)
		tween.connect("finished", _on_tween_finished)

func _on_tween_finished():
	self.get_tree().paused = false
	self.visible = false
	
