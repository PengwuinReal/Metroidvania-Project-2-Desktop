extends CharacterBody2D
var hp = 1
var life_state = "alive"
var targetpos = []
const SPEED = 0.1
func _ready():
	targetpos = $".".get_parent().get_parent().get_node("Player").global_position
	$".".look_at(targetpos)
	


func _physics_process(delta):
	if hp <= 0 and life_state == 'alive':
		
		queue_free()
	
	
	

	

	
	move_and_collide(velocity * SPEED * delta)
	
	move_and_slide()
	
func _on_hitbox_area_entered(area):
	if area.name == "Scythe" and area.attacking:
		hp -= 1
		


func _on_lifespan_timeout():
	hp = 0
