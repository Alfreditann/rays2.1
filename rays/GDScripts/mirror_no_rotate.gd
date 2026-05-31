extends StaticBody2D

@export var mirror_dir = 1
@onready var Sprite = $Sprite


func _ready() -> void:
	rotate_mirror()


func rotate_mirror():
	Sprite.play("rotation_" + str(mirror_dir))
