extends Node2D


#Kobler VideoStreamPlayer noden til et script som gjør at når animationen er ferdig så skal den ikke være synlig.
func _on_video_stream_player_finished() -> void:
	$VideoStreamPlayer.visible = false
	pass # Replace with function body.
