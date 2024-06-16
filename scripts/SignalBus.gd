extends Node

# Encounter phases
signal end_of_turn
signal start_of_turn
signal end_of_encounter

# User Actions
signal entity_clicked(target: Entity)

# Character
signal about_to_take_damage(reference: Character)
signal health_changed(reference: Character, health: int)
signal character_dead(reference: Character)

# Entity Animations
signal death_animation_finished(reference: EntityVFX)
