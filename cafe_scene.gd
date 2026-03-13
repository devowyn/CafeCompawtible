extends Node2D

@export var possible_customers: Array[PackedScene]
@onready var first_vet = $Vet 

var spawn_point: Vector2 

# NEW: A variable to remember who just walked in
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

	# 1. Pick a random customer
	var next_scene = possible_customers.pick_random()
	
	# 2. NEW LOGIC: If it's the same person who just left, pick again!
	# (The 'size > 1' check makes sure we don't get stuck in an infinite loop if you only have 1 customer loaded)
	while next_scene == last_customer_scene and possible_customers.size() > 1:
		next_scene = possible_customers.pick_random()
		
	# 3. Save this new person's ID so we remember them for next time
	last_customer_scene = next_scene
	
	# 4. Build them, position them, and add them to the game
	var new_customer = next_scene.instantiate()
	new_customer.position = spawn_point
	add_child(new_customer)
	
	new_customer.tree_exited.connect(spawn_next_customer)


func _on_tablet_screen_pressed() -> void:
	pass # Replace with function body.


func _on_go_to_pet_area_button_pressed():
	$PetArea.show() # This rolls the curtain down!
