extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
