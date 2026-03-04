extends Node2D

@onready var option_container = $OptionContainer
@onready var mute_btn = $OptionContainer/Mute
@onready var unmute_btn = $OptionContainer/Unmute

var is_open = false
var tween: Tween
var hidden_x: float
var shown_x: float

func _ready():
	shown_x = option_container.position.x
	hidden_x = shown_x + 600  # slides in from the right
	option_container.position.x = hidden_x
	option_container.visible = false

	# Show mute, hide unmute at start
	mute_btn.visible = true
	unmute_btn.visible = false

func toggle_panel():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)

	if not is_open:
		option_container.visible = true
		tween.tween_property(option_container, "position:x", shown_x, 0.4)
		is_open = true
	else:
		tween.tween_property(option_container, "position:x", hidden_x, 0.3)
		await tween.finished
		option_container.visible = false
		is_open = false

func on_mute_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	mute_btn.visible = false
	unmute_btn.visible = true

func on_unmute_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	mute_btn.visible = true
	unmute_btn.visible = false

func on_music_on_clicked():
	var current = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), min(current + 3.0, 0.0))

func on_music_off_clicked():
	var current = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), max(current - 3.0, -40.0))

func on_exit_clicked():
	get_tree().quit()

func on_x_clicked():
	toggle_panel()
