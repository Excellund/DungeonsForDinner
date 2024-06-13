extends Node

class_name EncounterManager

const SLIME_ENCOUNTER = preload("res://scripts/encounters/SlimeEncounter.gd")
const MUSHROOM_ENCOUNTER = preload("res://scripts/encounters/MushroomEncounter.gd")
const GOLEM_ENCOUNTER = preload("res://scripts/encounters/GolemEncounter.gd")

var encounters: Array = [
	SLIME_ENCOUNTER,
	MUSHROOM_ENCOUNTER,
	GOLEM_ENCOUNTER
]

func get_random_encounter() -> Encounter:
	var random_index = randi() % encounters.size()
	return encounters[random_index].new()
