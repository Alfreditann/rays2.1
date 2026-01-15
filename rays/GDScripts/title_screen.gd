extends Control


#Gjør at når knappen Back to Main Menu blir trykket så blir du sent til main menu scenen
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#Gjør at når Quit Game blir trykket så lukker prosjekte seg
func _on_quit_game_pressed() -> void:
	get_tree().quit()
