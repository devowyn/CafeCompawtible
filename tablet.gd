extends SubViewportContainer

@onready var tablet_screen = get_parent().get_node("TabletScreen")

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	gui_input.connect(_on_gui_input)

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("tablet clicked!")
			tablet_screen.open()
