extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	pass # Replace with function body.


func _on_main_menu_start_game_pressed():
	print("signal received")
	get_tree().change_scene_to_file("res://scenes/city/city.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
	pass
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/stage1.tscn")
