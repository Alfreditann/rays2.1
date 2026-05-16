extends Node2D

@export var tile_size := Vector2(32, 32)

var moving := false
var target_pos := Vector2.ZERO

func start_move(dir: Vector2) -> void:
	if moving:
		return

	moving = true
	target_pos = global_position + dir * tile_size

	var tween := create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.15)

	tween.finished.connect(func():
		global_position = target_pos
		moving = false
		)
