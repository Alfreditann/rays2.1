class_name MoveComponent
extends Node

#@export var gravity : float = 3000.0
@export var speed : float = 30.0
@onready var left_collision_ray: RayCast2D = $"../LeftCollisionRay"
@onready var right_collision_ray: RayCast2D = $"../RightCollisionRay"

@onready var parent: CharacterBody2D = get_parent()

var grabbed : bool = false
var player : Player = null

func _physics_process(delta: float) -> void:
	#_apply_gravity(delta)
	_push_movement()
	
	parent.move_and_slide()
	
#func _apply_gravity(delta : float) -> void:
	#if not parent.is_on_floor():
		#parent.velocity.y += gravity * delta
		
func _push_movement() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == _get_collision_normal() and direction:
		parent.velocity.x = speed * direction
	else:
		parent.velocity.x = 0.0
		
func _get_collision_normal() -> float:
	if left_collision_ray.is_colliding(): return 1.0
	elif right_collision_ray.is_colliding(): return -1.0
	else: return 0.0
	
func _is_interacting() -> bool:
	return left_collision_ray.is_colliding() or right_collision_ray.is_colliding()
	
func _get_collider() -> Player:
	for ray in [left_collision_ray, right_collision_ray]:
		if ray.is_colliding() and ray.get_collider() is Player:
			return ray.get_collider()
	return null
	

	
