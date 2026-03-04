extends Node2D

@onready var option_container = $OptionContainer
@onready var settings_background = $OptionContainer/SettingsBackground
@onready var overlay = $Overlay
@onready var settings_btn = $Settings
@onready var exit_btn = $OptionContainer/Exit
@onready var music_on_btn = $OptionContainer/MusicOn
@onready var music_off_btn = $OptionContainer/MusicOff
@onready var mute_btn = $OptionContainer/Mute
@onready var unmute_btn = $OptionContainer/Unmute

var is_open = false
var tween: Tween
var hidden_x: float
var shown_x: float

func _ready():
	shown_x = option_container.position.x
	hidden_x = shown_x + 1200
	option_container.position.x = hidden_x
	option_container.visible = false
	overlay.visible = false
	music_off_btn.visible = false
	music_on_btn.visible = true
	mute_btn.visible = false
	unmute_btn.visible = true
	exit_btn.visible = false

func toggle_panel():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	if not is_open:
		overlay.visible = true
		option_container.visible = true
		tween.tween_property(option_container, "position:x", shown_x, 0.4)
		is_open = true
		settings_btn.visible = false
		exit_btn.visible = true
	else:
		tween.tween_property(option_container, "position:x", hidden_x, 0.3)
		await tween.finished
		option_container.visible = false
		overlay.visible = false
		is_open = false
		settings_btn.visible = true
		exit_btn.visible = false

func on_music_slider_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	if value <= -40.0:
		music_on_btn.visible = false
		music_off_btn.visible = true
	else:
		music_on_btn.visible = true
		music_off_btn.visible = false

func on_sfx_slider_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	if value <= -40.0:
		unmute_btn.visible = false
		mute_btn.visible = true
	else:
		unmute_btn.visible = true
		mute_btn.visible = false

func on_mute_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)

func on_unmute_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)

func on_music_on_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)

func on_music_off_clicked():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)

func on_exit_clicked():
	get_tree().quit()
