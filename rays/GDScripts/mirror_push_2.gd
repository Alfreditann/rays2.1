extends CharacterBody2D

const TILE_SIZE := Vector2(32, 32)

var moving := false

func push(direction: Vector2):
	if moving:
		return
		
	moving = true
	
	var target_pos = global_position + direction * TILE_SIZE
	
	var tween = create_tween()
	
	tween.tween_property(
		self,
		"global_position",
		target_pos,
		0.15
	)
	tween.finished.connect(func():
		global_position = target_pos
		moving = false
	)
