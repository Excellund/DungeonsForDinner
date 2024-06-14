extends Node

@export var deck: CardPile
@export var hand: Hand
@export var discard: CardPile

@export var starting_hand_size: int


func _on_draw_in_turn():
	var new_cards: Array[Card] = deck.draw_card()
	hand.add_card_array_to_hand(new_cards, deck.global_position)


#signal for start of turn
func _on_turn_start():
	var new_cards: Array[Card] = deck.draw_card(starting_hand_size)
	hand.add_card_array_to_hand(new_cards, deck.global_position)


#signal for turn ending
func _on_turn_end():
	hand.remove_all_card_from_hand(discard.global_position)
