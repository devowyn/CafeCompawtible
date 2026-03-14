extends SubViewportContainer

@onready var tablet_screen = get_parent().get_node("TabletScreen")

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	gui_input.connect(_on_gui_input)

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("tablet clicked!")
			
			# --- THE SAFETY CHECK ---
			var active_customers = get_tree().get_nodes_in_group("Customer")
			
			if active_customers.size() > 0:
				var current_customer = active_customers[0]
				
				# Only open the menu if they haven't been served and aren't walking away!
				if current_customer.has_been_served == false and current_customer.is_leaving == false:
					
					# Open the menu!
					tablet_screen.show() 
			# ------------------------
