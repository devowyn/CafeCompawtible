extends HSlider

# This creates a slot in the Inspector. Drag your MusicPlayer node into it!
@export var music_player: AudioStreamPlayer

func _ready():
	# Sync the slider to whatever the volume currently is when the game starts
	if music_player != null:
		value = db_to_linear(music_player.volume_db)

func _on_value_changed(new_value: float) -> void:
	if music_player != null:
		# Change the volume using Godot's built-in decibel translator
		music_player.volume_db = linear_to_db(new_value)
		
		# Truly mute it if dragged all the way to the left
		if new_value <= 0.0001:
			music_player.volume_db = -80.0
