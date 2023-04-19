#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer

signal back_pressed

@onready var sfxh_slider: HSlider = %SFXHSlider
@onready var music_h_slider: HSlider = %MusicHSlider
@onready var window_button: Button = %WindowButton
@onready var back_button: Button = %BackButton


func _ready() -> void:
	window_button.pressed.connect(_on_window_button_pressed)
	sfxh_slider.value_changed.connect(_on_audio_slider_changed.bind("SFX"))
	music_h_slider.value_changed.connect(_on_audio_slider_changed.bind("Music"))
	back_button.pressed.connect(_on_back_button_pressed)
	update_display()


func update_display() -> void:
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	sfxh_slider.value = get_bus_volume_percent("SFX")
	music_h_slider.value = get_bus_volume_percent("Music")


func get_bus_volume_percent(bus_name: String) -> float:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var volume_db: float = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func set_bus_volume_percent(bus_name: String, percent: float) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var vouume_db: float = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, vouume_db)


func transition_effect() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway

	
func _on_window_button_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()


func _on_audio_slider_changed(value: float, bus_name: String) -> void:
	set_bus_volume_percent(bus_name, value)


func _on_back_button_pressed() -> void:
	transition_effect()
	back_pressed.emit()
