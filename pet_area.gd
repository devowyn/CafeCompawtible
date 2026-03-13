extends Node2D 

# --- DRAG AND DROP IMAGE SLOTS ---
@export var cat_base : Texture2D
@export var cat_pose_1 : Texture2D
@export var cat_pose_2 : Texture2D

@export var dog_base : Texture2D
@export var dog_pose_1 : Texture2D
@export var dog_pose_2 : Texture2D

# --- UI NODES ---
@onready var zoom_panel = $ZoomPanel
@onready var big_pet_display = $ZoomPanel/BigPetDisplay

# Tracks who we are looking at and what pose they are in!
var current_pet = ""
var pose_step = 0

func _ready():
	zoom_panel.hide()
	# Forces the image to your exact coordinates
	big_pet_display.position = Vector2(1015, 337)

# --- BACKGROUND PET CLICKS ---
func _on_cat_click_zone_pressed():
	current_pet = "Cat"
	pose_step = 0 # Reset pose counter when clicking a new pet
	big_pet_display.texture = cat_base
	zoom_panel.show()

func _on_dog_click_zone_pressed():
	current_pet = "Dog"
	pose_step = 0 # Reset pose counter when clicking a new pet
	big_pet_display.texture = dog_base
	zoom_panel.show()

# --- THE NEW PET BUTTON LOGIC ---
func _on_pet_button_pressed():
	# Add 1 to our pose counter
	pose_step += 1
	
	# If we go past pose 2, loop back to the base sprite (0)
	if pose_step > 2:
		pose_step = 0
		
	# Update the picture based on the current step!
	if current_pet == "Cat":
		if pose_step == 0: big_pet_display.texture = cat_base
		elif pose_step == 1: big_pet_display.texture = cat_pose_1
		elif pose_step == 2: big_pet_display.texture = cat_pose_2
	elif current_pet == "Dog":
		if pose_step == 0: big_pet_display.texture = dog_base
		elif pose_step == 1: big_pet_display.texture = dog_pose_1
		elif pose_step == 2: big_pet_display.texture = dog_pose_2

# --- THE CHOOSE BUTTON ---
func _on_choose_button_pressed():
	print("You officially chose the ", current_pet, "!")
	zoom_panel.hide()

# --- THE ESCAPE HATCH (BACK TO CAFE) ---
func _on_back_button_pressed():
	hide()
