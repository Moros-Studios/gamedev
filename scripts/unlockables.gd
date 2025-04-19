extends Node2D
class_name UnlockablesManager

signal money_changed(amount: int)
signal unlock_area_purchased(unlock_area: Unlock_Area)
signal show_message_signal(text: String)

# Add a property to store which buildings get unlocked
# This can be configured in the inspector
@export var buildings_to_unlock: Dictionary = {}

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
	else:
		show_message_signal.connect(message_display.show_message)
	_register_buildings()
	update_ui()

func _on_money_changed(amount: int):
	money_changed.emit(amount)
	update_ui()

func _register_buildings():
	for child in get_children():
		if child is Unlock_Area:
			child.purchase_requested.connect(_on_unlock_area_purchase_requested)

func _on_unlock_area_purchase_requested(unlock_area: Unlock_Area):
	if money_manager.can_afford(unlock_area.cost):
		purchase_building(unlock_area)
	else:
		reject_purchase(unlock_area)

func purchase_building(unlock_area: Unlock_Area):
	if money_manager.spend_money(unlock_area.cost):
		unlock_area.set_purchased()
		money_changed.emit(money_manager.current_money)
		unlock_area_purchased.emit(unlock_area)
		print(str(money_manager.current_money))
		emit_signal("show_message_signal", "Area unlocked successfully!")
		
		# Now unlock any buildings associated with this area
		unlock_buildings_for_area(unlock_area.name)
		
		update_ui()
	else:
		reject_purchase(unlock_area)

func unlock_buildings_for_area(area_name: String):
	# Check if we have any buildings registered for this area
	if not buildings_to_unlock.has(area_name):
		print("No buildings to unlock for area: " + area_name)
		return
	
	# Get the array of NodePaths for buildings
	var building_paths = buildings_to_unlock[area_name]
	for path_str in building_paths:
		# Try to get the node from the path
		var path = NodePath(path_str)
		if has_node(path):
			var building = get_node(path)
			if building.has_method("unlock"):
				print("Unlocking building at path: " + path_str)
				building.unlock()
			else:
				print("Building at path " + path_str + " has no unlock method!")
		else:
			print("Could not find building at path: " + path_str)

func reject_purchase(unlock_area: Unlock_Area):
	# Add visual feedback like shake effect
	var tween = create_tween().set_parallel(true)
	tween.tween_property(unlock_area, "position:x", unlock_area.position.x + 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x - 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x, 0.15)
	print("Not enough money to unlock this area! Need " + str(unlock_area.cost) + " coins")
	emit_signal("show_message_signal", "Not enough money! Need " + str(unlock_area.cost) + " coins")

func update_ui():
	# This would connect to your UI system
	pass

func add_money(amount: int):
	money_manager.add_money(amount)
