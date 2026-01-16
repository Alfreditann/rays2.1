extends CharacterBody2D

const TILE_SIZE := Vector2(32, 32)
const MOVE_TIME := 0.18

var player: Node = null
var moving := false


func _on_pushable_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body


func _on_pushable_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		
func _physics_process(delta: float) -> void:
	if moving:
		return
	if player and Input.is_action_just_pressed("ui_accept"):
		try_push(player.last_dir)
		
func try_push(dir: Vector2):
	var ray:= get_raycast_for_dir(dir)
	if ray == null:
		return
		
	ray.force_raycast_update()
	if ray.is_colliding():
		return
