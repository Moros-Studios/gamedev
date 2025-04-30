extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func game_over() -> void:
	get_tree().paused = true
	show()

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/city/city.tscn")

func _on_quit_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
