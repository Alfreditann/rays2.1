extends Control

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn") 


func _on_quit_game_pressed() -> void:
	get_tree().quit()
