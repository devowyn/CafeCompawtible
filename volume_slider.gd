extends HSlider

# The '%' tells it to find the Unique Node, and '@onready' tells it to WAIT until the game is loaded!
@onready var music_player = %MusicPlayer

func _ready():
	if music_player != null:
		value = db_to_linear(music_player.volume_db)

func _on_value_changed(new_value: float) -> void:
	if music_player != null:
		music_player.volume_db = linear_to_db(new_value)
		
		if new_value <= 0.0001:
			music_player.volume_db = -80.0
