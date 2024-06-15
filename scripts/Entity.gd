extends Node2D

class_name Entity

@export var character: Character
@export var vfx: EntityVFX
@export var health_bar: HealthBar

signal area_clicked(target: Entity)
signal dead(target: Character)

func _ready():
	vfx.death_animation_finished.connect(self._on_character_dead)
	health_bar.setup_health(character)

func _on_area_clicked():
	emit_signal("area_clicked", self)

func _on_character_dead():
	health_bar.queue_free()
	emit_signal("dead", character)
	
func attack(target: Entity):
	vfx.set_animation_state("attack")
	target.vfx.set_animation_state("hurt")
	character.attack(target.character)
