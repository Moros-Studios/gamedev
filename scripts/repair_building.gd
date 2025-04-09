#extends Area2D
#
#@export var repair_cost: int = 200  # Cost to repair this specific house
#
##@onready var repaired_house = $"Repaired House"
##@onready var demolished_house = $"Demolished House"
#@onready var collision_shape = $CollisionShape2D
#@onready var repaired_house: Sprite2D = $"Repaired Building"
#@onready var demolished_house: Sprite2D = $"Demolished Building"
#
#var repaired = false
#
#func _ready():
	## Make sure the initial states are correct
	#repaired_house.visible = false
	#demolished_house.visible = true
	#
	## No need to connect input_event here as the manager will handle that
#
#func repair_building():
	#if not repaired:
		## Switch the visibility of the sprites
		#repaired_house.visible = true
		#demolished_house.visible = false
		#repaired = true
		#
		## Optional: Play a repair sound effect
		## $RepairSound.play()
		#
		## Optional: Add particle effects
		## $RepairParticles.emitting = true
#
## Optional: Add a function to damage the building again if needed
#func damage_building():
	#if repaired:
		#repaired_house.visible = false
		#demolished_house.visible = true
		#repaired = false





extends Area2D

@export var repair_cost: int = 200  # Cost to repair this specific house
@export var unlocked: bool = false  # Whether this building is unlocked initially

@onready var collision_shape = $CollisionShape2D
@onready var repaired_house: Sprite2D = $"Repaired Building"
@onready var demolished_house: Sprite2D = $"Demolished Building"

var repaired = false

func _ready():
	# Make sure the initial states are correct
	repaired_house.visible = false
	demolished_house.visible = true
	
	# Set initial input pickable state based on unlocked status
	input_pickable = unlocked
	
	# Optional: Visual indication of locked state
	if not unlocked:
		modulate.a = 0.5  # Make it appear dimmer when locked

func repair_building():
	if not repaired:
		# Switch the visibility of the sprites
		repaired_house.visible = true
		demolished_house.visible = false
		repaired = true

# Call this function when the area is unlocked
func set_unlocked():
	unlocked = true
	input_pickable = true
	modulate.a = 1.0  # Restore full visibility
	
	# Optional: Add a visual effect to show it's now available
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.2, 1.2, 1.2, 1.0), 0.3)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1.0), 0.3)

# Optional: Add a function to damage the building again if needed
func damage_building():
	if repaired:
		repaired_house.visible = false
		demolished_house.visible = true
		repaired = false
