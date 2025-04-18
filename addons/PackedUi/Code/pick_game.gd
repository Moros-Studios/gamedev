extends Control

signal game_mode_selected(mode: String)

@onready var btn_2d_platformer = $Button2DPlatformer
@onready var btn_city_builder = $ButtonCityBuilder

func _ready() -> void:
	btn_2d_platformer.connect("pressed", Callable(self, "_on_2d_platformer_pressed"))
	btn_city_builder.connect("pressed", Callable(self, "_on_city_builder_pressed"))

func _on_2d_platformer_pressed() -> void:
	emit_signal("game_mode_selected", "2d_platformer")

func _on_city_builder_pressed() -> void:
	emit_signal("game_mode_selected", "city_builder")
