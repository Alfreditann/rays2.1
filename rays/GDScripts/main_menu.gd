extends Control


func _on_start_game_pressed() -> void: 
	get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")

func _on_settings_pressed() -> void:
	pass

func _on_quit_game_pressed() -> void:
	get_tree().quit()
