class_name DyttbarSpeil
extends CharacterBody2D

const tile_size: Vector2 = Vector2(32,32)
@onready var ray: RayCast2D = $RayCast2D

var directions = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT
}

func _try_push(dir: Vector2) -> bool:
	var move_vec = dir * tile_size
	
	ray.target_position = move_vec
	ray.force_raycast_update()
	
	#blocked by wall
	if ray.is_colliding():
		return false
		
	#move mirror
	global_position += move_vec
	return true

func _move(dir):
	var vector_pos = directions[dir]*tile_size
	
	ray.target_position = vector_pos
	ray.force_raycast_update()
	if not ray.colliding():
		position += vector_pos
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("DyttSpeil"):
			if collider.can_move(dir):
				vector_pos += vector_pos
				
		
