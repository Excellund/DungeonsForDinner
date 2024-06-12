extends Control

class_name MainMenu

const GAME = preload("res://scenes/game.tscn")

func _on_expedition_button_down():
	get_tree().change_scene_to_packed(GAME)

func _on_options_button_down():
	print("Options functionality not implemented yet.")

func _on_exit_button_down():
	get_tree().quit()
