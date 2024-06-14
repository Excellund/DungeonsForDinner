extends Node2D
class_name Hand

@export var position_curve: Curve
@export var HAND_WIDTH: int
@export var HAND_HEIGHT: int
@export var test_card: Card

@onready var hand_size: int = self.get_child_count()
const UPRIGHT_ROTATION: float = 0.0
const LEFT_ROTATION: float = PI/2
const MAX_HAND_ROTATION: float = PI/12


func add_card_to_hand(new_card:Card, from_pos:Vector2):
	hand_size += 1
	reorder_hand()
	new_card.reparent(self)
	var move_destination = get_adjusted_card_placment(new_card)
	new_card.move_to_from(from_pos, move_destination[0] , -LEFT_ROTATION, move_destination[1])


func add_card_array_to_hand(cards:Array[Card], from_pos:Vector2):
	hand_size += cards.size()
	reorder_hand()
	for card:Card in cards:
		self.add_child(card)
		var move_destination = get_adjusted_card_placment(card)
		card.move_to_from(from_pos, move_destination[0] , -LEFT_ROTATION, move_destination[1])


func remove_card_from_hand(card:Card, to_pos:Vector2):
	hand_size -= 1
	var tween = card.move_to_from_current(to_pos, LEFT_ROTATION)
	tween.connect("finished", _unchild_card.bind(card))
	tween.connect("finished", reorder_hand)


func remove_all_card_from_hand(to_pos:Vector2):
	hand_size = 0
	for card:Card in self.get_children():
		var tween = card.move_to_from_current(to_pos, LEFT_ROTATION)
		tween.connect("finished", _unchild_card.bind(card))


func get_adjusted_card_placment(card:Card):
	var card_destination := self.global_position
	var hand_ratio = float(card.get_index()) / float(hand_size-1)
	card_destination.x += lerp(-1,1,hand_ratio) * HAND_WIDTH
	card_destination.y += position_curve.sample(hand_ratio) * HAND_HEIGHT
	var rotation_destination = lerp(-MAX_HAND_ROTATION,MAX_HAND_ROTATION,hand_ratio)
	print(card.get_index()," | ", card_destination)
	
	return [card_destination, rotation_destination]


func reorder_hand():
	for card:Card in self.get_children():
		var move_destination = get_adjusted_card_placment(card)
		card.move_to_from_current(move_destination[0], move_destination[1])


func _unchild_card(card:Card):
	self.remove_child(card)



func _on_button_pressed():
	add_card_to_hand(test_card,Vector2(100,100))


func _on_button_2_pressed():
	remove_card_from_hand(test_card,Vector2(50,400))
