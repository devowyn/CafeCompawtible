extends Node2D

@onready var lamp: PointLight2D = $PointLight2D
@onready var timer: Timer = $"StartLightTimer"

func _ready():
	if lamp == null:
		push_error("PointLight2D not found under Table Lamp 1")
		return

	# Lamp completely disabled at start
	lamp.enabled = false
	lamp.energy = 0
	lamp.z_index = 0   # behind character (character has z_index = 5)

	# Configure timer to wait 7.5s before firing once
	timer.wait_time = 7.5
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# Enable lamp after 7.5s
	lamp.enabled = true
	lamp.energy = 1.0
