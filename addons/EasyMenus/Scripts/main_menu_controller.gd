extends Control
signal start_game_pressed
signal prologue_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var prologue_button: Button = %PrologueButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 

func _ready():
	start_game_button.grab_focus()
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	self.connect("start_game_pressed", Callable(self, "_on_start_game_pressed"))
	#prologue_button.grab_focus()
	self.connect("prologue_pressed", Callable(self, "_on_prologue_pressed"))

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/city/city.tscn")
	
func _on_prologue_pressed():
	Dialogic.start("res://Dialogue/timeline.dtl")
	#Dialogic.start("res://Dialogue/prolouge_final.dtl")
	#Dialogic.start("res://Dialogue/test.dtl")

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()


func _on_start_game_button_pressed():
	emit_signal("start_game_pressed")
	
func _on_prologue_button_pressed():
	emit_signal("prologue_pressed")
