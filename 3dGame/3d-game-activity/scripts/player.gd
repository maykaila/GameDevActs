extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Reference to the mesh so we can rotate it independently
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# --- ROLLING LOGIC ---
		# We rotate the mesh based on movement. 
		# The axis of rotation is perpendicular to the direction of movement.
		var rolling_axis = Vector3(direction.z, 0, -direction.x)
		
		# The amount to rotate (Angular Velocity = Linear Velocity / Radius)
		# Assuming a radius of 1.0; adjust the multiplier for faster/slower visual roll.
		var roll_speed = SPEED * delta 
		mesh.rotate(rolling_axis, roll_speed)
		# ---------------------
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
