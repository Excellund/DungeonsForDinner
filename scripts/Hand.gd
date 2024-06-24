extends Node2D
class_name Hand

@export var dead_card_holder: Node2D
@export var position_curve: Curve
@export var HAND_WIDTH: int
@export var HAND_HEIGHT: int

@onready var hand_size: int = self.get_child_count()
const UPRIGHT_ROTATION: float = 0.0
const LEFT_ROTATION: float = PI/2
const MAX_HAND_ROTATION: float = PI/12


func add_card_array_to_hand(cards:Array[Card], from_pos:Vector2):
	hand_size += cards.size()
	reorder_hand()
	for card:Card in cards:
		if not card.get_parent():
			self.add_child(card)
		else:
			card.reparent(self)
		var move_destination = get_adjusted_card_placment(card)
		card.move_to_from(from_pos, move_destination[0] , -LEFT_ROTATION, move_destination[1])


func remove_card_from_hand(card:Card, to_pos:Vector2):
	hand_size -= 1
	card.reparent(dead_card_holder)
	reorder_hand()
	var tween = card.move_to_from_current(to_pos, LEFT_ROTATION)
	tween.connect("finished", _unchild_card.bind(card))


func remove_all_card_from_hand(to_pos:Vector2) -> Array[Card]:
	hand_size = 0
	var removed_cards : Array[Card] = []
	for card:Card in self.get_children():
		card.reparent(dead_card_holder)
		removed_cards.append(card)
		var tween = card.move_to_from_current(to_pos, LEFT_ROTATION)
		tween.connect("finished", _unchild_card.bind(card))
	return removed_cards

func get_adjusted_card_placment(card:Card):
	var card_destination := self.global_position
	var hand_ratio: float
	if hand_size == 1:
		hand_ratio = 0.5
	else:
		hand_ratio = float(card.get_index()) / float(hand_size-1)
	
	card_destination.x += lerp(-1,1,hand_ratio) * HAND_WIDTH
	card_destination.y += position_curve.sample(hand_ratio) * HAND_HEIGHT
	var rotation_destination = lerp(-MAX_HAND_ROTATION,MAX_HAND_ROTATION,hand_ratio)
	
	return [card_destination, rotation_destination]


func reorder_hand():
	for card:Card in self.get_children():
		var move_destination = get_adjusted_card_placment(card)
		card.move_to_from_current(move_destination[0], move_destination[1])


func _unchild_card(card:Card):
	dead_card_holder.remove_child(card)



func _on_button_pressed():
	print("test")


func _on_button_2_pressed():
	print("other")
