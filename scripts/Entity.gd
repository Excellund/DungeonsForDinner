extends Node2D

class_name Entity

@onready var character = $Character

signal area_clicked(target: Character)

func _on_area_clicked():
	emit_signal("area_clicked", character)
