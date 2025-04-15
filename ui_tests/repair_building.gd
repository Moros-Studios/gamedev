extends Area2D

@export var repair_cost: int = 200  # Cost to repair this specific house

#@onready var repaired_house = $"Repaired House"
#@onready var demolished_house = $"Demolished House"
@onready var collision_shape = $CollisionShape2D
@onready var repaired_house: Sprite2D = $"Repaired Building"
@onready var demolished_house: Sprite2D = $"Demolished Building"

var repaired = false

func _ready():
	# Make sure the initial states are correct
	repaired_house.visible = false
	demolished_house.visible = true
	
	# No need to connect input_event here as the manager will handle that

func repair_building():
	if not repaired:
		# Switch the visibility of the sprites
		repaired_house.visible = true
		demolished_house.visible = false
		repaired = true
		
		# Optional: Play a repair sound effect
		# $RepairSound.play()
		
		# Optional: Add particle effects
		# $RepairParticles.emitting = true

# Optional: Add a function to damage the building again if needed
func damage_building():
	if repaired:
		repaired_house.visible = false
		demolished_house.visible = true
		repaired = false
