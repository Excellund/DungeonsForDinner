extends Control

class_name MainMenu

func _on_expedition_pressed():
	SceneManager.load_scene(SceneManager.SceneType.GAME)

func _on_options_pressed():
	print("Options functionality not implemented yet.")

func _on_exit_pressed():
	get_tree().quit()
