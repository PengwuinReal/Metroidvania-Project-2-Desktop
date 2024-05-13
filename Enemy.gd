extends CharacterBody2D
var gravity = 30
var hp = 3
var life_state = "alive"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if hp <= 0 and life_state == 'alive':
		print('apples')
		queue_free()
		
	"""
	Player location/enemy AI
	"""
	var selfpos = get_position()
	var targetpos = get_node()

	
	move_and_collide(Vector2(velocity.x, velocity.y))
	move_and_slide()
	


func _on_player_hit():
	pass # Replace with function body.


func _on_hitbox_area_entered(area):
	if area.name == "Scythe" and area.attacking:
		hp -= 1
		print(hp)
	
	



