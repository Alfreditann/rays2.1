extends Control


func _on_start_game_pressed() -> void: 
	#get_tree().change_scene_to_file("res://tscn/level_1.tscn")
	pass

func _on_settings_pressed() -> void:
	pass

func _on_quit_game_pressed() -> void:
	get_tree().quit()
