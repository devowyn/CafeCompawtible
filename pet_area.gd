extends Node2D

# --- UI Elements ---
@onready var customer_display = $CustomerDisplay
# Fixed the path to look inside the DialogueBox!
@onready var request_label = $DialogueBox/CustomerRequestLabel 
@onready var confirm_panel = $ConfirmPanel 
@onready var pet_preview = $ConfirmPanel/PetPreview

# --- Pet Pictures for the UI (Drag all 6 into the Inspector!) ---
@export var shy_cat_pic: Texture2D
@export var playful_cat_pic: Texture2D
@export var curious_cat_pic: Texture2D
@export var shy_dog_pic: Texture2D
@export var excited_dog_pic: Texture2D
@export var protective_dog_pic: Texture2D

# --- The Game's Memory ---
var wanted_pet = ""
var wanted_emotion = ""
var selected_pet = ""
var selected_emotion = ""

# --- Called by CafeScene right before the curtain drops ---
func update_visiting_customer(customer_node):
	# 1. Grab their face directly from the customer object
	customer_display.texture = customer_node.texture
	customer_display.flip_h = true 
	
	# 2. Steal the puzzle answers straight from the customer's brain!
	wanted_pet = customer_node.wanted_pet
	wanted_emotion = customer_node.wanted_pet_emotion
	
	# 3. Give the player the hint
	request_label.text = customer_node.pet_hint
	confirm_panel.hide()


# --- THE 6 CLICKABLE PET BUTTONS ---
func _on_shy_cat_button_pressed():
	ask_to_confirm("Cat", "Shy", shy_cat_pic)

func _on_playful_cat_button_pressed():
	ask_to_confirm("Cat", "Playful", playful_cat_pic)
	
func _on_curious_cat_button_pressed():
	ask_to_confirm("Cat", "Curious", curious_cat_pic)

func _on_shy_dog_button_pressed():
	ask_to_confirm("Dog", "Shy", shy_dog_pic)

func _on_excited_dog_button_pressed():
	ask_to_confirm("Dog", "Excited", excited_dog_pic)

func _on_protective_dog_button_pressed():
	ask_to_confirm("Dog", "Protective", protective_dog_pic)


# --- THE CONFIRMATION LOGIC ---
func ask_to_confirm(pet_type, pet_emotion, pet_image):
	# Remember what we clicked
	selected_pet = pet_type
	selected_emotion = pet_emotion
	
	# Slap the selected picture into the UI panel
	pet_preview.texture = pet_image
	
	# Show the Yes/No menu!
	confirm_panel.show()

func _on_no_button_pressed():
	confirm_panel.hide()

func _on_yes_button_pressed():
	# --- 1. DID WE WIN?! ---
	var is_correct = false
	if selected_pet == wanted_pet and selected_emotion == wanted_emotion:
		is_correct = true
		
	# --- 2. INSTANT LOCK: CLOSE AND UNPAUSE ---
	# We hide the pet menu and unpause the game so we are back in live time!
	confirm_panel.hide()
	self.hide() 
	get_tree().paused = false 
	
	# --- 3. BORROW THE CAFE EXPLOSIONS ---
	# We reach out to the main Cafe scene to grab the explosions you already made
	var cafe_correct_explosion = get_parent().get_node("CorrectExplosion")
	var cafe_wrong_explosion = get_parent().get_node("WrongExplosion")
	
	if is_correct:
		cafe_correct_explosion.global_position = get_global_mouse_position()
		cafe_correct_explosion.show() 
		cafe_correct_explosion.play("explode") 
	else:
		cafe_wrong_explosion.global_position = get_global_mouse_position()
		cafe_wrong_explosion.show() 
		cafe_wrong_explosion.play("explode") 

	# --- 4. THE FREEZE FRAME ---
	# Because the game is unpaused now, your normal 0.5s timer works perfectly!
	await get_tree().create_timer(0.5).timeout
	
	# --- 5. TELL THE CUSTOMER ---
	var active_customers = get_tree().get_nodes_in_group("Customer")
	
	if active_customers.size() > 0:
		var current_customer = active_customers[0]
		
		# Hand them the pet!
		if is_instance_valid(current_customer):
			if current_customer.has_method("receive_pet_and_leave"):
				current_customer.receive_pet_and_leave(is_correct)
