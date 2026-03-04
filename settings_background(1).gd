extends Sprite2D

func _ready():
	# Background doesn't need click detection
	# It just rides along with OptionContainer when it slides in/out
	set_process_unhandled_input(false)
