extends Node

@export var deck: CardPile
@export var hand: Hand
@export var discard: CardPile
@export var card_scene: PackedScene
@export var persistent_deck: StartingDeck
@export var starting_hand_size: int

func _ready():
	_on_pop_deck_pressed()
	SignalBus.start_of_turn.connect(_on_turn_start)
	SignalBus.end_of_turn.connect(_on_turn_end)
	SignalBus.end_of_encounter.connect(_on_end_of_encounter)
	SignalBus.card_effect_resolved.connect(_on_card_effect_resolved)
	SignalBus.request_add_card_to_perm_deck.connect(_on_request_add_card_to_perm_deck)
	SignalBus.add_card_action.connect(_on_add_card_action)

func _on_start_of_encounter():
	deck.shuffle_pile()


func _on_end_of_encounter(_encounter):
	#depending on order also need to move cards from hand to discard
	_refresh_draw_pile()


#signal for start of turn
func _on_turn_start():
	var new_cards: Array[Card] = deck.draw_card(starting_hand_size)
	hand.add_card_array_to_hand(new_cards, deck.global_position)


func _on_turn_end():
	var discarded_cards = hand.remove_all_card_from_hand(discard.global_position)
	discard.add_card_array(discarded_cards)


func _on_draw_pile_empty():
	deck.add_card_array(discard.deck)
	deck.shuffle_pile()
	discard.deck = []


func _on_draw_in_turn():
	var new_cards: Array[Card] = deck.draw_card()
	hand.add_card_array_to_hand(new_cards, deck.global_position)


func _draw_cards(cards_to_draw: int) -> Array[Card]:
	var new_cards: Array[Card] = []
	var draw_pile_size := deck.deck.size()
	var cards_after_draw = draw_pile_size - cards_to_draw
	if cards_after_draw >= 0:
		new_cards.append_array(deck.draw_card(cards_to_draw))
	else:
		new_cards.append_array(deck.draw_card(draw_pile_size))
		cards_to_draw -= draw_pile_size
		if _refresh_draw_pile():
			new_cards.append_array(_draw_cards(cards_to_draw))
		else:
			return new_cards
	return new_cards


func _refresh_draw_pile():
	if discard.deck.size() == 0:
		return false
	deck.add_card_array(discard.deck)
	deck.shuffle_pile()
	discard.deck = []
	return true

#signal for turn ending



func _on_card_effect_resolved(card):
	if not card.is_dead:
		hand.remove_card_from_hand(card ,discard.global_position)
		discard.add_card(card)
	else:
		self.persistent_deck.true_deck.erase(card)
		hand.remove_child(card)
		hand.hand_size -= 1
		hand.reorder_hand()
		card.queue_free()


func _on_request_add_card_to_perm_deck(card_data: CardData):
	var new_card = card_scene.instantiate()
	new_card.set_card_data(card_data)
	persistent_deck.true_deck.append(new_card)


func _on_add_card_action(card_data: CardData, target: String, is_temporary: bool):
	var new_card = card_scene.instantiate()
	new_card.set_card_data(card_data)
	
	match target:
		"Hand":
			hand.add_card_array_to_hand([new_card],Vector2(-960,540))
		"Deck":
			deck.add_card(new_card)
			deck.shuffle_pile()
		"Discard":
			discard.add_card(new_card)
		_:
			pass
	
	if not is_temporary:
		SignalBus.request_add_card_to_perm_deck.emit(card_data)


func _on_pop_deck_pressed():
	var new_deck = persistent_deck.initialize_deck().duplicate()
	deck.deck = new_deck
	deck.shuffle_pile()


func _on_new_hand_pressed():
	var new_hand = deck.draw_card(5)
	hand.add_card_array_to_hand(new_hand, deck.global_position)


func _on_dump_hand_pressed():
	hand.remove_all_card_from_hand(discard.global_position)
