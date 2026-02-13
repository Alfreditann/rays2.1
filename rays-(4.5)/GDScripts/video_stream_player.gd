extends VideoStreamPlayer


func _on_finished() -> void:
	$VideoStreamPlayer.visible = false
