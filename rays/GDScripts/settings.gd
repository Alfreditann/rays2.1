extends Control

@onready var master_slider: HSlider = $Master
@onready var music_slider: HSlider = $Music


const MIN_DB := -60.0
const MAX_DB := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var master_bus := AudioServer.get_bus_index("Master")
	var music_bus := AudioServer.get_bus_index("Music")
	
	master_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(master_bus))
	music_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(music_bus))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _slider_to_db(value: float) -> float:
	if value <= 0.0:
		return MIN_DB

	var linear = value / 100.0
	var db = linear_to_db(linear)
	return clamp(db, MIN_DB, MAX_DB)


func _db_to_slider(db: float) -> float:
	if db <= MIN_DB:
		return 0.0
	var linear = db_to_linear(db)
	return clamp(linear * 100.0, 0.0, 100.0)
	
func _set_volume(bus_name: String, value: float):
	var db = _slider_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)

	
func _on_volume_button_drag_ended(value_changed: bool) -> void:
	pass

func _on_music_value_changed(value: float) -> void:
	_set_volume("Music", value)


func _on_master_value_changed(value: float) -> void:
	_set_volume("Master", value)
