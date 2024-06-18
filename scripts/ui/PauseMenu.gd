extends Node2D

class_name PauseMenu

@export var resume: Button
@export var options: Button
@export var main_menu: Button

func _ready():
	resume.pressed.connect(_on_resume_pressed)
	options.pressed.connect(_on_options_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		show()

func _on_resume_pressed():
	hide()

func _on_options_pressed():
	pass

func _on_main_menu_pressed():
	_SceneManager.load_scene(_SceneManager.SceneType.MAIN_MENU)
