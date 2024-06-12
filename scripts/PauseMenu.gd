extends Node2D

class_name PauseMenu

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		show()

func _on_resume_pressed():
	hide()

func _on_options_pressed():
	pass

func _on_main_menu_pressed():
	SceneManager.load_scene(SceneManager.SceneType.MAIN_MENU)
