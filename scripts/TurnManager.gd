extends Node

enum TurnState {
	ENEMY,
	PLAYER
}

signal turn_ended

var current_turn: TurnState = TurnState.PLAYER

func change_turn():
	if current_turn == TurnState.PLAYER:
		current_turn = TurnState.ENEMY
	else:
		current_turn = TurnState.PLAYER
