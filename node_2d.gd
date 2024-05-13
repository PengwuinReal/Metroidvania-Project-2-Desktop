extends Node2D

@export var enemy_scene: PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 144
	$EnemySpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	

func _on_enemy_spawn_timer_timeout():
	# Create a new instance of the enemy scene.
	var enemy = enemy_scene.instantiate()

	# Spawn the enemy by adding it to the Main scene.
	add_child(enemy)
