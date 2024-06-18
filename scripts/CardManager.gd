extends Node

@export var deck: CardPile
@export var hand: Hand
@export var discard: CardPile

@export var starting_hand_size: int

func _ready():
	_on_pop_deck_pressed()
	SignalBus.start_of_turn.connect(_on_turn_start)
	SignalBus.end_of_turn.connect(_on_turn_end)
	SignalBus.end_of_encounter.connect(_on_end_of_encounter)
	SignalBus.card_used.connect(_on_card_used)

#TODO bug when deck and discard are both empty
func _on_start_of_encounter():
	deck.suffle_pile()


func _on_end_of_encounter():
	#depending on order also need to move cards from hand to discard
	_refresh_draw_pile()


func _on_draw_pile_empty():
	deck.add_card_array(discard.deck)
	deck.suffle_pile()
	discard.deck = []


func _on_draw_in_turn():
	var new_cards: Array[Card] = deck.draw_card()
	hand.add_card_array_to_hand(new_cards, deck.global_position)


#signal for start of turn
func _on_turn_start():
	var new_cards := _draw_cards(starting_hand_size)
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
	deck.suffle_pile()
	discard.deck = []
	return true

#signal for turn ending
func _on_turn_end():
	var discarded_cards = hand.remove_all_card_from_hand(discard.global_position)
	discard.add_card_array(discarded_cards)


func _on_card_used(card, _target, _is_attack_side):
	hand.remove_card_from_hand(card ,discard.global_position)
	discard.add_card(card)



func _on_pop_deck_pressed():
	deck._populate_deck(6)



func _on_new_hand_pressed():
	_on_turn_start()


func _on_dump_hand_pressed():
	_on_turn_end()
