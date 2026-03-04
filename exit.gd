extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_exit_clicked()
