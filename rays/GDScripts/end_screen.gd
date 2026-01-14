extends Control

#Kobler knappen Next til neste level scene
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn") 

#Kobler knappen quit til å lukke prosjektet når den blir trykket.
func _on_quit_game_pressed() -> void:
	get_tree().quit()
