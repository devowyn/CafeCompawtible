extends Sprite2D

@onready var settings_panel = get_parent().get_node("SettingsPanel")

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if visible:
				visible = false
				settings_panel.get_node("Settings").visible = true
				get_viewport().set_input_as_handled()
