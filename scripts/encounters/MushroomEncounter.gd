extends Encounter

class_name MushroomEncounter

const MUSHROOM = preload("res://scenes/enemies/mushroom.tscn")

const X: int = 1520
const Y: int = 800

func _init():
	super._init([MUSHROOM], [Vector2(X, Y)])
