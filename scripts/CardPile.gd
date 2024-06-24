extends Control
class_name CardPile

@export var view: Control
var deck: Array[Card] = []

func add_card(card:Card):
	deck.append(card)


func add_card_array(cards: Array[Card]):
	var cleaned_cards = cards.filter(_is_valid)
	deck.append_array(cleaned_cards)

func _is_valid(card) -> bool:
	return is_instance_valid(card)


func draw_card(number_of_cards:int = 1) -> Array[Card]:
	var drawn_cards: Array[Card] = []
	for i in number_of_cards:
		drawn_cards.append(deck.pop_back())
	return drawn_cards


func shuffle_pile():
	deck.shuffle()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			view.set_up_view(self.deck)
