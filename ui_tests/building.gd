extends Area2D
class_name Unlock_Area

signal purchase_requested(Unlock_Area_ref)

@export var cost: int = 500  # Set individually per Unlock_Area instance
@onready var polygon: Polygon2D = $Polygon2D

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		purchase_requested.emit(self)

func set_purchased():
	# Visual feedback
	var tween = create_tween()
	tween.tween_property(polygon, "color:a", 0.0, 0.3)
	
	# Disable further interaction
	$CollisionShape2D.set_deferred("disabled", true)
