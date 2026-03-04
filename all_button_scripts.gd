# ============================================================
# mute.gd  →  attach to Mute node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_mute_clicked()


# ============================================================
# unmute.gd  →  attach to Unmute node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_unmute_clicked()


# ============================================================
# music_on.gd  →  attach to MusicOn node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_music_on_clicked()


# ============================================================
# music_off.gd  →  attach to MusicOff node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_music_off_clicked()


# ============================================================
# exit.gd  →  attach to Exit node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_exit_clicked()


# ============================================================
# x.gd  →  attach to X node
# ============================================================
extends Sprite2D

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local_pos = to_local(event.position)
			if get_rect().has_point(local_pos):
				get_parent().get_parent().on_x_clicked()
