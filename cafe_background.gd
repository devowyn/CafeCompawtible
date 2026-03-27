extends Sprite2D

@export var phase_time: float = 30.0 # 30 seconds of Day, 30 seconds of Night

var timer: float = 0.0
var is_day: bool = true

var shader_mat: ShaderMaterial = preload("res://cafe_shader_material.tres")
var default_cone_len: float = 0.4

func _ready():
	material = shader_mat

func _process(delta):
	timer += delta

	# --- 1. THE 2-PHASE TOGGLE ---
	if timer >= phase_time:
		timer = 0.0
		is_day = !is_day

	# --- 2. THE SMOOTH FADE ---
	var target_brightness = 1.0 if is_day else 0.3
	var current_brightness = shader_mat.get_shader_parameter("brightness")
	var new_brightness = move_toward(current_brightness, target_brightness, delta * 0.5)
	
	shader_mat.set_shader_parameter("brightness", new_brightness)

	# --- 3. THE EXACT SYNC ---
	if new_brightness <= 0.6:
		# SNAP LIGHTS ON!
		shader_mat.set_shader_parameter("cone_len", default_cone_len)
		shader_mat.set_shader_parameter("lamp_energy", 1.0) # <--- Shader Lamp ON
	else:
		# SNAP LIGHTS OFF!
		shader_mat.set_shader_parameter("cone_len", 0.0)
		shader_mat.set_shader_parameter("lamp_energy", 0.0) # <--- Shader Lamp OFF
