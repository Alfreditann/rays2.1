extends Node

@export var menu_music: AudioStream
@export var gameplay_music: AudioStream

@onready var player = $MusicPlayer

func _play_menu_music():
	if player.stream == menu_music and player.playing:
		return
		
	player.stream = menu_music
	player.play()
	
func _play_gameplay_music():
	if player.stream == gameplay_music and player.playing:
		return
		
	player.stream = gameplay_music
	player.play()

func _ready() -> void:
	pass
