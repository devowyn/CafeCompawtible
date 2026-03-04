extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			visible = false
