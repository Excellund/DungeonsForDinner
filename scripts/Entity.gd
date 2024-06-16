extends Node2D

class_name Entity

@export var character: Character
@export var vfx: EntityVFX
@export var health_bar: HealthBar
@export var area: Area2D

func _ready():
	SignalBus.character_dead.connect(_on_character_dead)
	SignalBus.death_animation_finished.connect(_on_death_animation_finished)
	area.input_event.connect(_on_area_input)
	area.set_process_input(true)
	health_bar.setup_health(character)
	
func _on_area_input(_viewport: Node, event: InputEvent, _shape_idx: int):
	if TurnManager.current_turn == TurnManager.TurnState.PLAYER:
		if event.is_action_pressed("left_click"):
			SignalBus.entity_clicked.emit(self)
			
func _on_character_dead(reference: Character):
	if not reference == character:
		return
	
	vfx.set_animation_state("death")

func _on_death_animation_finished(reference: EntityVFX):
	if not reference == vfx:
		return
		
	health_bar.queue_free()
	
func attack(target: Entity):
	vfx.set_animation_state("attack")
	target.vfx.set_animation_state("hurt")
	character.attack(target.character)
