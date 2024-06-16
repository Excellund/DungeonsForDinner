extends Entity

class_name Player

func _ready():
	super._ready()
	SignalBus.entity_clicked.connect(_on_entity_clicked)

func _input(event):
	if not can_attack():
		return;

	if event.is_action_pressed("right_click"):
		vfx.set_animation_state("thrust")

func _on_entity_clicked(target: Entity):
	if not can_attack():
		return;
	
	attack(target)

func is_player_turn() -> bool:
	return TurnManager.current_turn == TurnManager.TurnState.PLAYER

func can_attack() -> bool:
	return is_player_turn() and not character.is_dead
