extends Area2D

class_name Hoverable

signal area_clicked

func _ready():
	set_process_input(true)

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		emit_signal("area_clicked")
