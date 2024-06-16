extends Control

class_name MainMenu

@export var expedition: Button
@export var options: Button
@export var exit: Button

func _ready(): 
	expedition.pressed.connect(_on_expedition_pressed)
	options.pressed.connect(_on_options_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _on_expedition_pressed():
	_SceneManager.load_scene(_SceneManager.SceneType.GAME)

func _on_options_pressed():
	print("Options functionality not implemented yet.")

func _on_exit_pressed():
	get_tree().quit()
