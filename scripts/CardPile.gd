extends Control
class_name CardPile

var deck: Array[Card] = []
@export var card_scene: PackedScene


func add_card(card:Card):
	deck.append(card)


func add_card_array(cards: Array[Card]):
	deck.append_array(cards)


func draw_card(number_of_cards:int = 1) -> Array[Card]:
	var drawn_cards: Array[Card] = []
	for i in number_of_cards:
		drawn_cards.append(deck.pop_back())
	return drawn_cards


func suffle_pile():
	deck.shuffle()

# testing function
func _populate_deck(number_of_cards:int = 5):
	for i in number_of_cards:
		var new_card = card_scene.instantiate()
		deck.push_back(new_card)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		pass # load view deck scene
