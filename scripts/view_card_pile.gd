extends Control


@export var card_grid: GridContainer
@export var pile_name: Label
@export var card_scene: PackedScene
var last_array: Array[Card] = []

func set_up_view(card_pile_cards: Array[Card]):
	#if the last viewed deck is the same as this one
	if last_array == card_pile_cards:
		self.visible = true
		return
	else:
		_clean_up_view()
	
	last_array = card_pile_cards.duplicate()
	
	for card in card_pile_cards:
		var new_data := card.card_data
		var new_card = card_scene.instantiate()
		new_card.set_card_data(new_data)
		card_grid.add_child(new_card)
	self.visible = true


func _on_back_button_pressed():
	self.visible = false


func _clean_up_view():
	for card in card_grid.get_children():
		card.queue_free()
