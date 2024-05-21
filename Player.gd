extends CharacterBody2D

signal hit
const WALL_BOUNCE = 10.0 #amount of speed
var SPEED = 10.0 #left and right speed
const JUMP_VELOCITY = -15.0
const RESISTANCE = 0.1 # "sliding" in air
const SLIDE = 0.7 # sliding on ground
const CLIMB_SPEED = 5.0
var FACING = 1 #left = -1 right = 1, for a boolean
var ATK = 10000 #attack scythe hitbox (not damage)
var life_force = 5
var life_state = 'alive'
var kills = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 30



		
		
func _physics_process(delta):
	#print(delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")

	
	if Input.is_action_pressed("sprint"):
		SPEED = 20
	else:
		SPEED = 10
	if life_force <= 0 and life_state == 'alive':
		life_state = 'dead'
		$"Camera2D/Hud/BlackBackdrop".visible = true
		$"Camera2D/Hud/GameOver".visible = true
		$"Camera2D/Hud/GameOver".set_text("Game Over\nScore: " + str(kills))
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction: #left = -1 right = 1
		velocity.x = direction * SPEED
		if Input.is_action_pressed("left") and FACING == 1: 
			scale.x = -1
			FACING = -1
			$"Camera2D".scale.x = -1
			
		if Input.is_action_pressed("right") and FACING == -1:
			scale.x = -1
			FACING = 1
			$"Camera2D".scale.x = 1
	
			
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

	move_and_collide(Vector2(velocity.x, velocity.y))
	move_and_slide()


func _on_area_2d_body_entered(body):
	if 'CharacterBody2D' in body.name or 'Enemy' in body.name or 'Bullet' in body.name:
		life_force -= 1

