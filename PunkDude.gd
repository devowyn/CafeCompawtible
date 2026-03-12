extends Sprite2D

@onready var dialogue_box = $"../DialogueBox" 
@onready var dialogue_label = $"../DialogueBox/DialogueLabel"

var target_y = 670 
var speed = 700
var has_ordered = false
var is_leaving = false

var menu_drinks = [
	"Pawfee Latte", 
	"Woof Cocoa", 
	"Meowcha Green Tea", 
	"Compawtible Milk-Tea", 
	"Purrfect Frappe", 
	"Tail-Wagging Tropical Punch"
]

func _ready():
	# DIAGNOSTIC CHECK: Let's prove if Godot actually sees them!
	print("Found Box: ", dialogue_box)
	print("Found Label: ", dialogue_label)
	
	dialogue_box.visible = false

func _process(delta):
	if is_leaving:
		position.x -= speed * delta
		if position.x < -200: 
			queue_free() 
		return
		
	if position.y > target_y:
		position.y -= speed * delta 
	else:
		position.y = target_y 
		if not has_ordered:
			show_dialogue()

func show_dialogue():
	has_ordered = true
	var chosen_drink = menu_drinks.pick_random()
	
	print("Customer ordered: ", chosen_drink)
	
	# NO MORE SAFETY CHECKS! If the path is wrong, Godot will crash here and tell us!
	dialogue_label.text = "I would like a " + chosen_drink + "!"
	dialogue_box.visible = true

func start_leaving():
	is_leaving = true
	dialogue_box.visible = false
