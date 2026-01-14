extends StaticBody2D



func _on_monster_area_entered(area: Area2D) -> void:
		#1 Remove the monster when light hits it
	if area.name == "laser" || "laser_test":
		queue_free()	
		#2 Change scene to win screen
		get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")



func _on_monster_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
