extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_jumping = false

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reset jump state when landing
		if is_jumping:
			is_jumping = false
			sprite.play("idle")  # Play idle animation when landing

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true  # Start jump
		sprite.play("jump")  # Play jump animation

	# Get the input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		
		# Play run animation only if not jumping
		if not is_jumping:
			sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Play idle animation only if not jumping
		if not is_jumping:
			sprite.play("idle")

	move_and_slide()
