extends Node2D

class_name GameManager

@onready var player = $Player

var encounter: Encounter 
var enemies: Array[Entity] = []

func _ready():
	next_encounter()
		
func _on_entity_death(character: Character):
	for enemy: Entity in enemies:
		if not enemy.character.is_dead:
			return
	
	next_encounter()

func setup_encounter(new_encounter: Encounter):
	for enemy in enemies:
		enemy.queue_free()
	
	encounter = new_encounter
	enemies.clear()

	for i in range(encounter.enemies.size()):
		var enemy_instance: Entity = encounter.enemies[i].instantiate()
		enemy_instance.position = encounter.locations[i]
		enemy_instance.area_clicked.connect(player._on_enemy_clicked)
		enemy_instance.dead.connect(self._on_entity_death)
		enemies.append(enemy_instance)
		add_child(enemy_instance)
	
func next_encounter():
	setup_encounter(_EncounterManager.get_random_encounter())
	
