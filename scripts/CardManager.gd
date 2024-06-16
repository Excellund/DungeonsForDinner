extends Node

@export var deck: CardPile
@export var hand: Hand
@export var discard: CardPile

@export var starting_hand_size: int


func _on_start_of_encounter():
	deck.suffle_pile()


func _on_draw_pile_empty():
	deck.add_card_array(discard.deck)
	deck.suffle_pile()
	discard.deck = []


func _on_end_of_encounter():
	#depending on order also need to move cards from hand to discard
	deck.add_card_array(discard.deck)
	deck.suffle_pile()
	discard.deck = []


func _on_draw_in_turn():
	var new_cards: Array[Card] = deck.draw_card()
	hand.add_card_array_to_hand(new_cards, deck.global_position)


#signal for start of turn
func _on_turn_start():
	var new_cards: Array[Card] = deck.draw_card(starting_hand_size)
	hand.add_card_array_to_hand(new_cards, deck.global_position)


#signal for turn ending
func _on_turn_end():
	var discarded_cards = hand.remove_all_card_from_hand(discard.global_position)
	discard.add_card_array(discarded_cards)


func _on_pop_deck_pressed():
	deck._populate_deck(20)


func _on_new_hand_pressed():
	var new_hand = deck.draw_card(5)
	hand.add_card_array_to_hand(new_hand, deck.global_position)


func _on_dump_hand_pressed():
	hand.remove_all_card_from_hand(discard.global_position)
