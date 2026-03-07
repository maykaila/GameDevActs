extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -250.0
var jump_count = 0
const MAX_JUMPS = 2

@onready var animated_sprite = $AnimatedSprite2D
@onready var sfx_jump: AudioStreamPlayer2D = $sfxJump
@onready var sfx_walk: AudioStreamPlayer2D = $sfxWalk

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count = 1
			animated_sprite.play("jump") # Play normal jump
			sfx_jump.play()
		elif jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			animated_sprite.play("double jump") # Play double jump!
	
	if is_on_floor():
		jump_count = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveleft", "moveright")
	
	# flip sprite base on direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# play animations
	if is_on_floor():
		if direction != 0: # This covers both forward (1) and backward (-1)
			animated_sprite.play("running")
			if not sfx_walk.playing: 
				sfx_walk.play()
		else:
			animated_sprite.play("idle")
			sfx_walk.stop() # Stop immediately when input stops
	else:
		sfx_walk.stop() # Stop immediately if we jump or fall
		if animated_sprite.animation != "double jump":
			animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
