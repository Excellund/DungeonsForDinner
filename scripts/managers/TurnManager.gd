extends Node

enum TurnState {
	ENEMY,
	PLAYER
}

var current_turn: TurnState = TurnState.PLAYER

func change_turn():
	if current_turn == TurnState.PLAYER:
		SignalBus.end_of_turn.emit()
		current_turn = TurnState.ENEMY
	else:
		current_turn = TurnState.PLAYER
		SignalBus.start_of_turn.emit()
