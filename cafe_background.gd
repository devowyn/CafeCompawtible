extends Sprite2D

var real_day_length = 60.0   # 1 minute for testing
var elapsed = 0.0
var active = false
var shader_mat : ShaderMaterial = preload("res://cafe_shader_material.tres")

func _ready():
	# Start with no shader applied
	material = null

func _process(delta):
	if active:
		elapsed += delta
		if elapsed > real_day_length:
			elapsed = 0.0  # restart cycle

		var t = elapsed / real_day_length
		var brightness = lerp(1.0, 0.3, t)
		shader_mat.set_shader_parameter("brightness", brightness)

func start_shader():
	# Apply the shader when you want it to kick in
	material = shader_mat
	active = true

# Called when StartDimTimer reaches 60 seconds
func _on_start_dim_timer_timeout() -> void:
	start_shader()   # begin dimming

# Called when FullShaderTimer reaches 120 seconds
func _on_full_shader_timer_timeout() -> void:
	shader_mat.set_shader_parameter("brightness", 0.3)
	active = false   # stop updating, lock at dimmest
