extends Node2D

class_name GameManager

@onready var player = $Player

var encounter: Encounter 

func _ready():
	encounter = SlimeEncounter.new()
	
	for i in range(encounter.enemies.size()):
		var enemy_instance = encounter.enemies[i].instantiate()
		enemy_instance.position = encounter.locations[i]
		enemy_instance.area_clicked.connect(player._on_enemy_clicked)
		add_child(enemy_instance)
