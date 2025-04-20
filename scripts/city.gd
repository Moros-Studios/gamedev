extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_main_menu_start_game_pressed():
	print("signal received")
	get_tree().change_scene_to_file("res://scenes/city/city.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
