extends Control

@onready var label = $Label
var timer = null

func _ready():
	print("Children of MessageDisplay: ", get_children())
	print("Does Label exist by path? ", has_node("Label"))
	#label = get_node("Label")
	if label == null:
		print("ERROR: Label node not found in MessageDisplay")
	else:
		print("Label found successfully!")
	
	timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timeout"))
	add_child(timer)

	# Make sure we're hidden initially
	hide()

func show_message(text: String):
	print("DEBUG: show_message called with text: " + text)
	if label != null:
		label.text = text
		print("Setting message: " + text) # Debugging
	else:
		print("CRITICAL ERROR: Label is null when trying to display message")
	
	# Make sure visibility is properly set
	visible = true
	show()
	timer.start()

func _on_timeout():
	hide()
	if label != null:
		label.text = ""
