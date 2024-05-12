extends Node2D

@export var enemy_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 144
	$EnemySpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
func _on_enemy_timer_timeout():
	# Create a new instance of the enemy scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var enemy_spawn_location = $enemyPath/enemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()

	# Set the enemy's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2

	# Set the enemy's position to a random location.
	enemy.position = enemy_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the enemy.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the enemy by adding it to the Main scene.
	add_child(enemy)
"""
