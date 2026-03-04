extends Sprite2D

@onready var settings_btn = $"../SettingsPanel/Settings"

func _ready():
	set_process_unhandled_input(true)
	settings_btn.visible = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			visible = false
			settings_btn.visible = true
