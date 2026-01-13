extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
			
func _on_return_to_game_pressed() -> void:
	visible = false
	get_tree().paused = false
	print("Return")
	
func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	print("Restart")
	
func _on_quit_to_main_menu_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	print("Quit To Main Meny")
