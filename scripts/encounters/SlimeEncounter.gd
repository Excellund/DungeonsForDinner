extends Encounter

class_name SlimeEncounter

const SLIME = preload("res://scenes/slime.tscn")

const X: int = 280
const Y: int = -40

func _init():
	super._init([SLIME], [Vector2(X, Y)])
