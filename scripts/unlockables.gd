#extends Node2D
#class_name UnlockablesManager
#
#@export var starting_money: int = 500
#var current_money: int
#
#signal money_changed(amount: int)
#signal unlock_area_purchased(unlock_area: Unlock_Area)
#
#func _ready():
	#current_money = starting_money
	#_register_buildings()
	#update_ui()
#
#func _register_buildings():
	#for child in get_children():
		#if child is Unlock_Area:
			#child.purchase_requested.connect(_on_unlock_area_purchase_requested)
#
#func _on_unlock_area_purchase_requested(unlock_area: Unlock_Area):
	#if can_afford(unlock_area.cost):
		#purchase_building(unlock_area)
	#else:
		#reject_purchase(unlock_area)
#
#func can_afford(amount: int) -> bool:
	#return current_money >= amount
#
#func purchase_building(unlock_area: Unlock_Area):
	#current_money -= unlock_area.cost
	#unlock_area.set_purchased()
	#money_changed.emit(current_money)
	#unlock_area_purchased.emit(unlock_area)
	#update_ui()
#
#func reject_purchase(unlock_area: Unlock_Area):
	## Add visual feedback like shake effect
	#var tween = create_tween().set_parallel(true)
	#tween.tween_property(unlock_area, "position:x", unlock_area.position.x + 8, 0.05)
	#tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x - 8, 0.05)
	#tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x, 0.15)
	#print("Not enouogh money")
#
#func update_ui():
	## This would connect to your UI system
	#pass
#
#func add_money(amount: int):
	#current_money += amount
	#money_changed.emit(current_money)
	#update_ui()




extends Node2D
class_name UnlockablesManager

@export var starting_money: int = 500
var current_money: int

signal money_changed(amount: int)
signal unlock_area_purchased(unlock_area: Unlock_Area)

# Add this export to connect unlock areas to their buildings
@export var buildings_to_unlock: Dictionary = {
	"House 4": ["Houses/Blacksmith"],
	"House 3": ["Houses/General Store"],
	"House 5": ["Houses/Training Center"]
}  # Format: "unlock_area_name": ["building_path1", "building_path2"]

func _ready():
	current_money = starting_money
	_register_buildings()
	update_ui()

func _register_buildings():
	for child in get_children():
		if child is Unlock_Area:
			child.purchase_requested.connect(_on_unlock_area_purchase_requested)

func _on_unlock_area_purchase_requested(unlock_area: Unlock_Area):
	if can_afford(unlock_area.cost):
		purchase_building(unlock_area)
	else:
		reject_purchase(unlock_area)

func can_afford(amount: int) -> bool:
	return current_money >= amount

func purchase_building(unlock_area: Unlock_Area):
	current_money -= unlock_area.cost
	unlock_area.set_purchased()
	money_changed.emit(current_money)
	unlock_area_purchased.emit(unlock_area)
	
	# Unlock associated buildings
	unlock_buildings_in_area(unlock_area.name)
	
	update_ui()

func unlock_buildings_in_area(area_name: String):
	# Check if this area has any buildings to unlock
	if buildings_to_unlock.has(area_name):
		for building_path in buildings_to_unlock[area_name]:
			if has_node(building_path):
				var building = get_node(building_path)
				if building.has_method("set_unlocked"):
					building.set_unlocked()

func reject_purchase(unlock_area: Unlock_Area):
	# Add visual feedback like shake effect
	var tween = create_tween().set_parallel(true)
	tween.tween_property(unlock_area, "position:x", unlock_area.position.x + 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x - 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x, 0.15)
	print("Not enough money")

func update_ui():
	# This would connect to your UI system
	pass

func add_money(amount: int):
	current_money += amount
	money_changed.emit(current_money)
	update_ui()
