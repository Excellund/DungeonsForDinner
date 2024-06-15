extends Area2D

class_name Hoverable

signal area_clicked

func _ready():
	set_process_input(true)

func _on_input_event(_viewport, event, _shape_idx):
	if TurnManager.current_turn == TurnManager.TurnState.PLAYER:
		if event.is_action_pressed("left_click"):
			emit_signal("area_clicked")
