class_name CityScene extends SMenuControl


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	UI.ButtonPressed.connect(_on_button_pressed)


func _on_button_pressed(id: String, from: String) -> void:
	if id == "play":
		visible = true
	else:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
