extends Sprite2D

@onready var dialogue_box = $"../DialogueBox" 
@onready var dialogue_label = $"../DialogueBox/DialogueLabel"

# --- MOVEMENT SETTINGS ---
var target_y = 670 
var speed = 700

# --- THE CUSTOMER'S MEMORY ---
var has_ordered = false
var is_leaving = false
var has_been_served = false
var wanted_drink = ""

var menu_drinks = [
	"Pawfee Latte", 
	"Woof Cocoa", 
	"Meowcha Green Tea", 
	"Compawtible Milk-Tea", 
	"Purrfect Frappe", 
	"Tail-Wagging Tropical Punch"
]

func _ready():
	dialogue_box.visible = false

# --- MOVEMENT LOGIC ---
func _process(delta):
	if is_leaving:
		# Walk out the door!
		position.x -= speed * delta
		if position.x < -200: 
			queue_free() # Delete them so the next person can spawn
		return
		
	# Walk up to the counter!
	if position.y > target_y:
		position.y -= speed * delta 
	else:
		position.y = target_y 
		if not has_ordered:
			show_dialogue()


# --- PHASE 1: ORDERING THE DRINK ---
func show_dialogue():
	has_ordered = true
	wanted_drink = menu_drinks.pick_random()
	
	print("Customer ordered: ", wanted_drink)
	
	dialogue_label.text = "I would like a " + wanted_drink + "!"
	dialogue_box.visible = true


# --- PHASE 2: RECEIVING THE DRINK ---
func receive_drink(given_drink: String):
	if given_drink == wanted_drink:
		# THEY GOT THE RIGHT DRINK!
		has_been_served = true
		
		var happy_texts = ["Delicious!", "Exactly what I needed!", "Perfect, thank you!"]
		dialogue_label.text = happy_texts.pick_random()
		
		# 1. Wait 2 seconds for them to enjoy the drink
		await get_tree().create_timer(2.0).timeout
		
		# 2. Change their text to ask for a pet!
		request_pet_dialogue() 
		
		# 3. Wait 2 MORE seconds so you can read it
		await get_tree().create_timer(2.0).timeout
		
		# 4. MAGIC TELEPORT! Tell the Cafe to drop the curtain!
		var cafe_manager = get_tree().current_scene
		if cafe_manager.has_method("_on_go_to_pet_area_button_pressed"):
			cafe_manager._on_go_to_pet_area_button_pressed()
			
	else:
		# WE GAVE THEM THE WRONG DRINK!
		var angry_texts = ["Um... this isn't what I ordered.", "I guess I'll just drink this...", "Not my favorite. I'm leaving."]
		dialogue_label.text = angry_texts.pick_random()
		
		# Wait 2.5 seconds so the player can feel the guilt, then kick them out!
		await get_tree().create_timer(2.5).timeout
		start_leaving()


# --- PHASE 3: ASKING FOR A PET ---
func request_pet_dialogue():
	dialogue_label.text = "Thanks for the drink! I'd love to meet a pet now."
	dialogue_box.visible = true


# --- PHASE 4: RECEIVING THE PET & LEAVING ---
func receive_pet_and_leave(is_correct_pet: bool):
	var happy_thanks = [
		"Oh, this is absolutely perfect! Thank you!",
		"Exactly who I was looking for! We're going to be best friends.",
		"You read my mind! I love them already."
	]
	
	var sad_thanks = [
		"Oh... I guess this one is okay. Thanks.",
		"Not exactly what I asked for, but I'll give them a loving home.",
		"Um, sure. I'll take them. Have a good day."
	]
	
	# Check if the player won or lost!
	if is_correct_pet == true:
		dialogue_label.text = happy_thanks.pick_random()
	else:
		dialogue_label.text = sad_thanks.pick_random()
	
	dialogue_box.visible = true
	
	# Pause for 2.5 seconds so we can read the text
	await get_tree().create_timer(2.5).timeout
	start_leaving()


# --- THE FINAL EXIT ---
func start_leaving():
	is_leaving = true
	dialogue_box.visible = false
