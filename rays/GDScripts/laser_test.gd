extends RigidBody2D


var speed := 130
var last_hit_time := 0.0
var hit_delay := 0.2 # prevents multiple triggers per frame
var rect_shape1 = 0
@onready var anim = $AnimatedSprite2D
func _ready():
	linear_velocity = -global_transform.x * speed
	$laser_test.area_entered.connect(_on_laser_test_area_entered)

	
	$Timer.wait_time = 0.3
	$Timer.start()
	# Physics safety
	gravity_scale = 0
	lock_rotation = true   # Godot 4 property; if Godot 3 use 'freeze' or 'can_sleep' settings accordingly
	angular_velocity = 0
	# Make sure the body isn't sleeping when we set velocity
	sleeping = false

func start_motion() -> void:
	# Compute velocity from the current rotation
	linear_velocity = Vector2.RIGHT.rotated(rotation).normalized() * speed
	sleeping = false
	# Debug:


func _on_laser_test_area_entered(area: Area2D) -> void:
		# Prevent duplicate trigger if still colliding
	if Time.get_ticks_msec() - last_hit_time < hit_delay * 1000:
		return
