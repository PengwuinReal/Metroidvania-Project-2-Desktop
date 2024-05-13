extends Area2D
var ATK = 10000
var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		ATK = 0
		attacking = true
	if ATK < 125:
		$".".set_rotation_degrees(ATK-25)
		ATK += 4
	if ATK >= 125:
		$".".set_rotation_degrees(0)
		attacking = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
