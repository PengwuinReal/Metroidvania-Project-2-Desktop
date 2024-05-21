extends TextureProgressBar
var FACING = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_value($".".get_parent().get_parent().get_parent().life_force)
	
	
		
		
	
