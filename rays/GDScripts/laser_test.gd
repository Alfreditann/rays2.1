extends RigidBody2D


var speed := 200
var last_hit_time := 0.0
var hit_delay := 0.2 # prevents multiple triggers per frame
var rect_shape1 = 0
var dir := Vector2.ZERO
@onready var anim = $AnimatedSprite2D

func _ready():
	add_to_group("laser")
	anim.play("Middle")
	linear_velocity = -global_transform.x * speed
	$Timer.wait_time = 0.3
	$Timer.start()
	# Physics safety
	gravity_scale = 0
	lock_rotation = true   # Godot 4 property; if Godot 3 use 'freeze' or 'can_sleep' settings accordingly
	angular_velocity = 0
	# Make sure the body isn't sleeping when we set velocity
	sleeping = false
	linear_velocity = Vector2.LEFT.rotated(rotation) * speed
	
	if dir != Vector2.ZERO:
		linear_velocity = dir.normalized() * speed
		rotation = dir.angle()
func start_motion() -> void:
	# Compute velocity from the current rotation
	linear_velocity = Vector2.RIGHT.rotated(rotation).normalized() * speed
	sleeping = false
	# Debug:

func _on_laser_test_area_entered(area: Area2D) -> void:
	if area.name == "speil_hitbox":
		linear_velocity = Vector2.RIGHT * speed
		anim.play("Middle")
		print("Hit")
	elif area.name == "speil_hitbox2":
		linear_velocity = Vector2.UP * speed
		anim.play("up")
	if area.name == "hurtbox":
		queue_free()
	if area.name == "monster":
		queue_free()
