extends Node

class_name Encounter

var enemies: Array[PackedScene]
var locations: Array[Vector2]

func _init(enemies: Array[PackedScene], locations: Array[Vector2]):
	self.enemies = enemies
	self.locations = locations
