extends Node2D
class_name UnlockablesManager

@export var starting_money: int = 1000
var current_money: int

signal money_changed(amount: int)
signal unlock_area_purchased(unlock_area: Unlock_Area)

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
	update_ui()

func reject_purchase(unlock_area: Unlock_Area):
	# Add visual feedback like shake effect
	var tween = create_tween().set_parallel(true)
	tween.tween_property(unlock_area, "position:x", unlock_area.position.x + 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x - 8, 0.05)
	tween.chain().tween_property(unlock_area, "position:x", unlock_area.position.x, 0.15)
	print("Not enouogh money")

func update_ui():
	# This would connect to your UI system
	pass

func add_money(amount: int):
	current_money += amount
	money_changed.emit(current_money)
	update_ui()
