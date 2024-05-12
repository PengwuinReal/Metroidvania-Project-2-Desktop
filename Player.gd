extends CharacterBody2D

signal hit
const WALL_BOUNCE = 10.0 #amount of speed
var SPEED = 10.0 #left and right speed
const JUMP_VELOCITY = -15.0
const RESISTANCE = 0.1 # "gliding" in air
const SLIDE = 0.7 # sliding on ground
const CLIMB_SPEED = 5.0
var FACING = 1 #left = -1 right = 1, for a boolean
var ATK = 10000 #attack scythe hitbox (not damage)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 30

func positionreset(): # when a key is pressed, will set the position and set velocities to 0
	var spawn_x = 360
	var spawn_y = -220
	position = Vector2(spawn_x, spawn_y)
	velocity.x = 0
	velocity.y = 0
	
func _input(event):
	if Input.is_key_pressed(KEY_R): #reset character to spawn button
		positionreset()
	
		
		
func _physics_process(delta):
	#print(delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if Input.is_action_pressed("sprint"):
		SPEED = 20
	else:
		SPEED = 10
	if Input.is_action_just_pressed("attack"):
		ATK = 0
	if ATK < 125:
		$"Scythe".set_rotation_degrees(ATK-25)
		ATK += 4
	if ATK >= 125:
		$"Scythe".set_rotation_degrees(0)
	"""
	if Input.is_action_just_pressed("attack"):
		$"Scythe".set_rotation_degrees(-50)
	if $"Scythe".get_rotation_degrees() <= 100 and Input.is_action_pressed("attack"):
		$"Scythe".set_rotation_degrees($"Scythe".get_rotation_degrees() + 10)
	if Input.is_action_just_released("attack") or $"Scythe".get_rotation_degrees() >= 100:
		$"Scythe".set_rotation_degrees(0)
	"""
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction: #left = -1 right = 1
		velocity.x = direction * SPEED
		if Input.is_action_pressed("left") and FACING == 1: 
			scale.x = -1
			FACING = -1
		if Input.is_action_pressed("right") and FACING == -1:
			scale.x = -1
			FACING = 1
		#print(velocity.x) #debug
		#print(scale.x)
	else:
		if is_on_floor(): 
			velocity.x = move_toward(velocity.x, 0, SLIDE)
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, RESISTANCE)
	
	
	if is_on_floor() and Input.is_action_pressed("jump"):#jumping on a floor
		velocity.y = JUMP_VELOCITY
		
	if is_on_wall():
		if Input.is_action_pressed("grab"):#wall grab
			velocity.y = 0
			if Input.is_action_pressed("up"):#wall climb up
				velocity.y = -CLIMB_SPEED
			if Input.is_action_pressed("down"):#wall climb down
				velocity.y = CLIMB_SPEED
		var wall_normal = get_wall_normal()#debug
		if Input.is_action_pressed("jump"):#wall jump
			velocity.y = JUMP_VELOCITY
		
			if wall_normal[0] < 0: #on left side of wall
				velocity.x = -WALL_BOUNCE 
				
			else: #on right side of wall
				velocity.x = WALL_BOUNCE
		#print(wall_normal[0])#debug
		#print(velocity.x)#debug
				
	move_and_collide(Vector2(velocity.x, velocity.y))
	move_and_slide()














func _on_hit():
	pass # Replace with function body.
