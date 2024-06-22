extends Node

# Encounter phases
signal end_of_turn
signal start_of_turn
signal end_of_encounter(encounter: Encounter)

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
signal card_effect_resolved(card: Card)
signal request_add_card_to_perm_deck(card_data: CardData)

# Actions
signal nourishment_applied(reference: Character, nourishment: Nourishment)
signal damage_increase(reference: Character, amount: int)
