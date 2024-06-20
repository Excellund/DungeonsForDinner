extends Resource
class_name StartingDeck


@export var card_scene: PackedScene
@export var cards_dict: Dictionary

var true_deck: Array[Card] = []


func _init():
	pass


func initialize_deck() -> Array[Card]:
	var deck: Array[Card] = []
	for card_data in cards_dict:
		for i in cards_dict[card_data]:
			var new_card: Card = card_scene.instantiate()
			await new_card.set_card_data(card_data.duplicate())
			deck.append(new_card)
	self.true_deck = deck
	return deck
