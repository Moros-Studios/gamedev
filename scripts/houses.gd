extends Node2D
class_name HousesManager

signal money_changed(amount: int)
signal house_repaired(house_area: Area2D)

var money_manager
var message_display

func _ready():
	money_manager = get_node("/root/Money_Manager")
	message_display = get_node("/root/MessageDisplay")
	if money_manager != null:
		money_manager.money_changed.connect(_on_money_changed)
	else:
		print("Error: MoneyManager node not found at /root/Money_Manager")
	if message_display == null:
		print("Error: MessageDisplay node not found at /root/MessageDisplay")
	register_houses()
	update_ui()

func _on_money_changed(amount: int):
	money_changed.emit(amount)
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
	# First check if the house can be repaired (is it unlocked?)
	if not house_area.can_be_repaired():
		if not house_area.unlocked:
			print("This area is locked! You need to unlock it first.")
		elif house_area.repaired:
			print("This house is already repaired!")
		return
		
	# Now use the house's specific repair cost
	var cost = house_area.repair_cost
	if money_manager.can_afford(cost):
		repair_house(house_area, cost)
	else:
		reject_repair(house_area, cost)

func repair_house(house_area: Area2D, cost: int):
	if money_manager.spend_money(cost):
		# Call the repair_building method on the Area2D script
		house_area.repair_building()
		
		house_repaired.emit(house_area)
		update_ui()
		
		print("House repaired for " + str(cost) + " coins")
		if message_display != null:
			message_display.show_message("House repaired for " + str(cost) + " coins")
	else:
		reject_repair(house_area, cost)

func reject_repair(house_area: Area2D, cost: int):
	# Add visual feedback like shake effect
	var tween = create_tween().set_parallel(true)
	tween.tween_property(house_area, "position:x", house_area.position.x + 8, 0.05)
	tween.chain().tween_property(house_area, "position:x", house_area.position.x - 8, 0.05)
	tween.chain().tween_property(house_area, "position:x", house_area.position.x, 0.15)
	print("Not enough money to repair house! Need " + str(cost) + " coins")
	if message_display != null:
		message_display.show_message("Not enough money to repair house! Need " + str(cost) + " coins")

func update_ui():
	# This would connect to your UI system
	# Example: $UI/MoneyLabel.text = str(money_manager.current_money)
	pass

func add_money(amount: int):
	money_manager.add_money(amount)
