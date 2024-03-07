extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 144


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
"""
var playerScreen=preload("res://Player.gd")
var t = playerScreen.instance()

func _input(ev):
	if Input.is_key_pressed(KEY_R):
		remove_child(t)
		t = playerScreen.instance()
		add_child(t)
"""
