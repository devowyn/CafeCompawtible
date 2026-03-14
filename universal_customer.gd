extends Sprite2D

# --- CUSTOM CUSTOMER SETTINGS ---
@export var walk_speed: float = 700.0
@export var target_y: float = 670.0

# --- FACIAL EXPRESSIONS (Drag in Inspector!) ---
@export var happy_face: Texture2D
@export var sad_face: Texture2D
@export var rbf_face: Texture2D

@onready var dialogue_box = $"../DialogueBox" 
@onready var dialogue_label = $"../DialogueBox/DialogueLabel"

# --- THE CUSTOMER'S MEMORY ---
var has_ordered = false
var is_leaving = false
var has_been_served = false
var wanted_drink = ""

# --- NEW: PET MEMORY ---
var wanted_pet = ""
var wanted_pet_emotion = ""
var pet_hint = ""

var menu_drinks = [
	"Pawfee Latte", "Woof Cocoa", "Meowcha Green Tea", 
	"Compawtible Milk-Tea", "Purrfect Frappe", "Tail-Wagging Tropical Punch"
]

func _ready():
	if dialogue_box != null:
		dialogue_box.visible = false
		
	# 1. Roll the dice for the pet they want the exact moment they spawn!
	var pet_options = [
		{"pet": "Cat", "emotion": "Shy", "hint": "I have a quiet, cozy hiding spot perfect for a timid little friend.", "face": "sad"},
		{"pet": "Cat", "emotion": "Playful", "hint": "I have a bunch of feather wands and laser pointers ready to go!", "face": "happy"},
		{"pet": "Dog", "emotion": "Shy", "hint": "I'm looking for a sweet, nervous pup who needs a patient owner.", "face": "sad"},
		{"pet": "Dog", "emotion": "Excited", "hint": "I run five miles every morning and need a buddy to keep up!", "face": "happy"},
		# --- YOUR NEW PETS ---
		{"pet": "Cat", "emotion": "Curious", "hint": "I need a smart little explorer who investigates every nook and cranny.", "face": "rbf"},
		{"pet": "Dog", "emotion": "Protective", "hint": "I want a sturdy, loyal friend who will keep a close watch on the front door.", "face": "rbf"}
	]
	
	var chosen_pet = pet_options.pick_random()
	wanted_pet = chosen_pet["pet"]
	wanted_pet_emotion = chosen_pet["emotion"]
	pet_hint = chosen_pet["hint"]
	
	# 2. Slap the correct face on them!
	if chosen_pet["face"] == "sad" and sad_face != null:
		texture = sad_face
	elif chosen_pet["face"] == "happy" and happy_face != null:
		texture = happy_face
	elif chosen_pet["face"] == "rbf" and rbf_face != null:
		texture = rbf_face

# --- MOVEMENT LOGIC ---
func _process(delta):
	if is_leaving:
		position.x -= walk_speed * delta
		if position.x < -200: 
			queue_free()
		return
		
	if position.y > target_y:
		position.y -= walk_speed * delta 
	else:
		position.y = target_y 
		if not has_ordered:
			show_dialogue()

# --- PHASE 1: ORDERING ---
func show_dialogue():
	has_ordered = true
	wanted_drink = menu_drinks.pick_random()
	dialogue_label.text = "I would like a " + wanted_drink + "!"
	dialogue_box.visible = true

# --- PHASE 2: RECEIVING DRINK ---
func receive_drink(given_drink: String):
	if given_drink == wanted_drink:
		has_been_served = true
		var happy_texts = ["Delicious!", "Exactly what I needed!", "Perfect, thank you!"]
		dialogue_label.text = happy_texts.pick_random()
		
		await get_tree().create_timer(2.0).timeout
		request_pet_dialogue() 
		await get_tree().create_timer(2.0).timeout
		
		var cafe_manager = get_tree().current_scene
		if cafe_manager.has_method("_on_go_to_pet_area_button_pressed"):
			cafe_manager._on_go_to_pet_area_button_pressed()
	else:
		var angry_texts = ["Um... this isn't what I ordered.", "I guess I'll just drink this...", "Not my favorite. I'm leaving."]
		dialogue_label.text = angry_texts.pick_random()
		
		await get_tree().create_timer(2.5).timeout
		start_leaving()

# --- PHASE 3 & 4: THE PET ---
func request_pet_dialogue():
	dialogue_label.text = "Thanks for the drink! I'd love to meet a pet now."
	dialogue_box.visible = true

func receive_pet_and_leave(is_correct_pet: bool):
	var happy_thanks = ["Oh, this is absolutely perfect! Thank you!", "Exactly who I was looking for!", "You read my mind!"]
	var sad_thanks = ["Oh... I guess this one is okay.", "Not exactly what I asked for...", "Um, sure. I'll take them."]
	
	if is_correct_pet == true:
		dialogue_label.text = happy_thanks.pick_random()
	else:
		dialogue_label.text = sad_thanks.pick_random()
	
	dialogue_box.visible = true
	await get_tree().create_timer(2.5).timeout
	start_leaving()

func start_leaving():
	is_leaving = true
	dialogue_box.visible = false
