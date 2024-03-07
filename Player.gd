extends CharacterBody2D

const WALL_BOUNCE = 10.0
const SPEED = 10.0 
const JUMP_VELOCITY = -15.0
const RESISTANCE = 0.1 # "gliding" in air
const SLIDE = 0.7 # sliding on ground


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 30

func positionreset(): # when a key is pressed, will set the position and set velocities to 0
	var spawn_x = 360
	var spawn_y = -220
	position = Vector2(spawn_x, spawn_y)
	velocity.x = 0
	velocity.y = 0
	
func _input(event):
	if Input.is_key_pressed(KEY_R):
		positionreset()
		
func _physics_process(delta):
	#print(delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if direction:
		velocity.x = direction * SPEED
		#print(velocity.x)
	else:
		if is_on_floor(): 
			velocity.x = move_toward(velocity.x, 0, SLIDE)
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, RESISTANCE)
		
	# Handle jump.
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall():
			var wall_normal = get_wall_normal()
			velocity.y = JUMP_VELOCITY
			print(wall_normal[0])
			if wall_normal[0] < 0: #on left side of wall
				velocity.x = -WALL_BOUNCE # move_toward(position.x, -1*SPEED, delta*-SPEED)
				print(velocity.x)
				
			else: #on right side of wall
				velocity.x = WALL_BOUNCE
				
	move_and_collide(Vector2(velocity.x, velocity.y))
	move_and_slide()

