extends Node2D

class_name Entity

@export var character: Character
@export var vfx: EntityVFX
@export var area: Area2D
@export var health_bar: HealthBar
@export var nourishment_container: GridContainer

func _ready():
	SignalBus.character_dead.connect(_on_character_dead)
	SignalBus.death_animation_finished.connect(_on_death_animation_finished)
	SignalBus.nourishment_applied.connect(_on_nourishment_applied)
	area.input_event.connect(_on_area_input)
	area.set_process_input(true)
	health_bar.setup_health(character)
	update_nourishment_container()
	
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
		
	nourishment_container.queue_free()
	health_bar.queue_free()
	
func attack(target: Entity):
	vfx.set_animation_state("attack")
	target.vfx.set_animation_state("hurt")
	character.attack(target.character)
	
func _on_nourishment_applied(reference: Character, _nourishment: Nourishment):
	if not reference == character:
		return
		
	update_nourishment_container()
	
func update_nourishment_container():
	for nourishment: Nourishment in character.nourishments:
		if nourishment_container.get_children().has(nourishment):
			continue
			
		nourishment_container.add_child(nourishment)
