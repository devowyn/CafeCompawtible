extends Node2D

@export var possible_customers: Array[PackedScene]
@onready var first_vet = $Vet 

var spawn_point: Vector2 
var last_customer_scene: PackedScene 

func _ready():
	randomize()
	if first_vet != null:
		spawn_point = first_vet.position 
		first_vet.tree_exited.connect(spawn_next_customer)

func spawn_next_customer():
	if possible_customers.is_empty():
		print("Dude, the customer list is empty!")
		return 

	var next_scene = possible_customers.pick_random()
	
	while next_scene == last_customer_scene and possible_customers.size() > 1:
		next_scene = possible_customers.pick_random()
		
	last_customer_scene = next_scene
	
	var new_customer = next_scene.instantiate()
	new_customer.position = spawn_point
	add_child(new_customer)
	
	new_customer.tree_exited.connect(spawn_next_customer)


func _on_go_to_pet_area_button_pressed():
	var active_customers = get_tree().get_nodes_in_group("Customer")
	
	if active_customers.size() > 0:
		var current_customer = active_customers[0] 
		
		# --- THE SECURITY CHECK ---
		if current_customer.has_been_served == false:
			print("Stop! You must click the Tablet to serve them a drink first!")
			return # Instantly stops the code!
		# --------------------------
		
		# Send the ENTIRE CUSTOMER object to the Pet Area so it can read their mind
		$PetArea.update_visiting_customer(current_customer)
		
		# Drop the curtain!
		$PetArea.show()


# --- THE MASTER SERVE FUNCTION ---
func serve_specific_drink(drink_name: String):
	# Hide the tablet instantly!
	if has_node("TabletScreen"):
		$TabletScreen.hide() 
	
	var active_customers = get_tree().get_nodes_in_group("Customer")
	
	if active_customers.size() > 0:
		var current_customer = active_customers[0]
		
		if current_customer.has_been_served or current_customer.is_leaving:
			return 
			
		if current_customer.has_method("receive_drink"):
			current_customer.receive_drink(drink_name)


# --- YOUR 6 BUTTON CONNECTIONS ---
func _on_pawfee_button_pressed():
	serve_specific_drink("Pawfee Latte")

func _on_woof_cocoa_button_pressed():
	serve_specific_drink("Woof Cocoa")

func _on_meowcha_button_pressed():
	serve_specific_drink("Meowcha Green Tea")

func _on_compawtible_button_pressed():
	serve_specific_drink("Compawtible Milk-Tea")

func _on_purrfect_frappe_button_pressed():
	serve_specific_drink("Purrfect Frappe")

func _on_tropical_punch_button_pressed():
	serve_specific_drink("Tail-Wagging Tropical Punch")
	
func _on_go_to_fake_area_button_pressed():
	$PetAreaFake.show()
	get_tree().paused = true


func _on_go_to_fake_area_pressed() -> void:
	pass # Replace with function body.


func _on_start_light_timer_timeout() -> void:
	pass # Replace with function body.
