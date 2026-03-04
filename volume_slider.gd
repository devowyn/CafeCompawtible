extends HSlider

func _ready():
	custom_minimum_size = Vector2(0, 0)
	min_value = -40.0
	max_value = 0.0
	value = 0.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0.0)
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value):
	get_parent().get_parent().on_music_slider_changed(new_value)
