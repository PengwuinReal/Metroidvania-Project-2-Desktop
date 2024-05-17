extends CharacterBody2D
var gravity = 30
var hp = 1
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
		$".".get_parent().get_node("Player").kills += 1
	
		
	"""
	Player location/enemy AI
	"""
	
	var targetpos = $".".get_parent().get_node("Player").position
	if position[0] > targetpos[0]:
		velocity.x = -4
	else:
		velocity.x = 4
	
	
	
	move_and_collide(Vector2(velocity.x, velocity.y))
	move_and_slide()
	


func _on_player_hit():
	pass # Replace with function body.


func _on_hitbox_area_entered(area):
	if area.name == "Scythe" and area.attacking:
		hp -= 1
		print(hp)
	
	



