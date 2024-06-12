extends Encounter

class_name GolemEncounter

const GOLEM = preload("res://scenes/enemies/golem.tscn")

const X: int = 1520
const Y: int = 1000

func _init():
	super._init([GOLEM], [Vector2(X, Y)])
