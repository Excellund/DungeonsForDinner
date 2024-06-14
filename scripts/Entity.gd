extends Node2D

class_name Entity

@onready var character: Character = $Character
@onready var vfx: EntityVFX = $VFX
@onready var health_bar: HealthBar = $"Health Bar"

signal area_clicked(target: Character)
signal dead(target: Character)

func _ready():
	vfx.death_animation_finished.connect(self._on_character_dead)
	health_bar.setup_health(character)

func _on_area_clicked():
	emit_signal("area_clicked", character)

func _on_character_dead():
	health_bar.queue_free()
	emit_signal("dead", character)
