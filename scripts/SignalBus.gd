extends Node

# Encounter phases
signal end_of_turn
signal start_of_turn
signal end_of_encounter

# User Actions
signal entity_clicked(target: Entity)

# Character
signal about_to_take_damage(reference: Character)
signal max_health_changed(reference: Character, new_max_health: int)
signal health_changed(reference: Character, health: int)
signal character_dead(reference: Character)

# Entity Animations
signal death_animation_finished(reference: EntityVFX)

# Card Actions
signal card_used(card: Card, target: Entity, is_attack_side: bool)
signal card_modified(card: Card, is_attack_side: bool)

# Actions
signal nourishment_applied(reference: Character, nourishment: Nourishment)
signal damage_increase(reference: Character, amount: int)
