extends Area2D

@export var repair_cost: int = 200  # Cost to repair this specific house
@export var unlocked: bool = false  # Is this building unlocked and available for repair?

@onready var repaired_house: Sprite2D = $"Repaired Building"
@onready var demolished_house: Sprite2D = $"Demolished Building"

var repaired = false

func _ready():
	# Make sure the initial states are correct
	repaired_house.visible = false
	demolished_house.visible = true
	
	# Visual indication if locked (optional)
	if not unlocked:
		modulate.a = 0.5

# Called from HousesManager before attempting repair
func can_be_repaired() -> bool:
	return unlocked and not repaired

func repair_building():
	# This should only be called after checking can_be_repaired()
	# but add a double-check just to be safe
	if not repaired and unlocked:
		repaired_house.visible = true
		demolished_house.visible = false
		repaired = true

# Called from UnlockablesManager when area is purchased
func unlock():
	if not unlocked:
		unlocked = true
		modulate.a = 1.0  # Restore full visibility
		print("Building unlocked and now available for repair")
