extends Control

#Kobler StartGame knappen til å gå til level 1 scenen når trykket.
func _on_start_game_pressed() -> void: 
	get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")

func _on_settings_pressed() -> void:
	pass

#Gjør at når knappen blir trykket så lukker prosjektet seg.
func _on_quit_game_pressed() -> void:
	get_tree().quit()
