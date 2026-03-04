extends Sprite2D

@onready var dialogue_box = $"../DialogueBox"
@onready var dialogue_label = $"../DialogueBox/DialogueLabel"

var target_y = 540
var speed = 700
var has_ordered = false
var order_text = "I'd like a latte!"   # <-- customize per customer

func _ready():
	# Dialogue box hidden at start (only once, but safe to call here too)
	dialogue_box.visible = false

func _process(delta):
	if position.y > target_y:
		position.y -= speed * delta
	else:
		position.y = target_y
		if not has_ordered:
			show_dialogue()

func show_dialogue():
	has_ordered = true
	dialogue_label.text = order_text   # Each customer sets their own text
	dialogue_box.visible = true
