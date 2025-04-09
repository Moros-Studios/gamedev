extends Node2D
class_name HousesManager

@export var starting_money: int = 1000
var current_money: int

signal money_changed(amount: int)
signal house_repaired(house_area: Area2D)

func _ready():
	current_money = starting_money
	register_houses()
	update_ui()

func register_houses():
	for child in get_children():
		if child is Area2D:
			# Connect the input event signal to check for clicks
			child.input_event.connect(_on_house_input_event.bind(child))

func _on_house_input_event(_viewport, event, _shape_idx, house_area: Area2D):
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		attempt_repair(house_area)

func attempt_repair(house_area: Area2D):
	# Check if the house is already repaired
	if house_area.repaired:
		print("This house is already repaired!")
		return
		
	# Now use the house's specific repair cost
	var cost = house_area.repair_cost
	if can_afford(cost):
		repair_house(house_area, cost)
	else:
		reject_repair(house_area, cost)

func can_afford(amount: int) -> bool:
	return current_money >= amount

func repair_house(house_area: Area2D, cost: int):
	current_money -= cost
	
	# Call the repair_building method on the Area2D script
	house_area.repair_building()
	
	money_changed.emit(current_money)
	house_repaired.emit(house_area)
	update_ui()
	
	print("House repaired for " + str(cost) + " coins")

func reject_repair(house_area: Area2D, cost: int):
	# Add visual feedback like shake effect
	var tween = create_tween().set_parallel(true)
	tween.tween_property(house_area, "position:x", house_area.position.x + 8, 0.05)
	tween.chain().tween_property(house_area, "position:x", house_area.position.x - 8, 0.05)
	tween.chain().tween_property(house_area, "position:x", house_area.position.x, 0.15)
	print("Not enough money to repair house! Need " + str(cost) + " coins")

func update_ui():
	# This would connect to your UI system
	# Example: $UI/MoneyLabel.text = str(current_money)
	pass

func add_money(amount: int):
	current_money += amount
	money_changed.emit(current_money)
	update_ui()
