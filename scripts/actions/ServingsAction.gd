extends Action

class_name ServingsAction

var card: Card
var card_data: CardData


func _init(card: Card):
	self.card = card
	self.card_data = card.card_data
	act()
	
func act():
	card_data.eat_actions["Servings"] -= 1
	if card_data.eat_actions["Servings"] == 0:
		card.is_dead = true
		#signal card eaten?
	else:
		card.card_modified.emit(false)
