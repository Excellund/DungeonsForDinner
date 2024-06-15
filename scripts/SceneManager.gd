extends Node

const GAME = preload("res://scenes/game.tscn")
const MAIN_MENU = preload("res://scenes/main_menu.tscn")

enum SceneType {
	MAIN_MENU,
	GAME
}

func _ready():
	load_scene(SceneType.MAIN_MENU)

func load_scene(scene_type: SceneType):
	match scene_type:
		SceneType.MAIN_MENU:
			get_tree().change_scene_to_packed(MAIN_MENU)
		SceneType.GAME:
			get_tree().change_scene_to_packed(GAME)
