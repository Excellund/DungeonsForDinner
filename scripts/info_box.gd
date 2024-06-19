extends Control

class_name InfoBox

@export var header: Label
@export var description: Label

func _ready():
	SignalBus.update_info_box_header.connect(_on_update_header)
	SignalBus.update_info_box_description.connect(_on_update_description)

func _on_update_header(reference: InfoBox, new_header: String):
	if not reference == self:
		return
	
	header.text = new_header
	
func _on_update_description(reference: InfoBox, new_description: String):
	if not reference == self:
		return
	
	description.text = new_description
