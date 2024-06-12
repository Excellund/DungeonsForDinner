extends Encounter

class_name SlimeEncounter

const SLIME = preload("res://scenes/enemies/slime.tscn")

const X: int = 1520
const Y: int = 1000

func _init():
	super._init([SLIME], [Vector2(X, Y)])
