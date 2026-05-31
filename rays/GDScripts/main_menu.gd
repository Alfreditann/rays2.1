extends Control

func _ready() -> void:
	AudioManager._play_menu_music()
	
#Kobler StartGame knappen til å gå til level 1 scenen når trykket.
func _on_start_game_pressed() -> void: 
	AudioManager._play_gameplay_music()
	get_tree().change_scene_to_file("res://Scenes/level_idk.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")
	

#Gjør at når knappen blir trykket så lukker prosjektet seg.
func _on_quit_game_pressed() -> void:
	get_tree().quit()
