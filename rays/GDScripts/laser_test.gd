extends RigidBody2D

var speed := 200
var last_hit_time := 0.0
var hit_delay := 0.2
var rect_shape1 = 0
var dir := Vector2.ZERO
var last_hit_mirror: Node = null

const TILE_SIZE := 32

var distance := 3 # number of tiles remaining

var tile_progress := 0.0

@onready var anim = $AnimatedSprite2D


func _ready():
	add_to_group("laser")

	anim.play("Middle")

	gravity_scale = 0
	lock_rotation = true
	angular_velocity = 0
	sleeping = false

	linear_velocity = Vector2.LEFT.rotated(rotation) * speed

	if dir != Vector2.ZERO:
		linear_velocity = dir.normalized() * speed
		rotation = dir.angle()


func _physics_process(delta):
	# accumulate movement
	var move_amount = speed * delta
	tile_progress += move_amount

	# convert pixels → tiles
	while tile_progress >= TILE_SIZE:
		tile_progress -= TILE_SIZE
		distance -= 1

		if distance <= 0:
			queue_free()


func _on_laser_test_area_entered(area: Area2D) -> void:
	if area.name == "speil_hitbox":
		var mirror = area.get_parent()

		if mirror == last_hit_mirror:
			return

		last_hit_mirror = mirror

		# 🔥 ADD 3 TILES ON HIT (THIS IS YOUR REQUEST)
		distance += 3

		var going = Decide_Vel(linear_velocity, mirror)

		if going != null:
			dir = going
			call_deferred("_apply_bounce", going)
		else:
			queue_free()

	if area.name == "hurtbox":
		queue_free()

	if area.name == "monster":
		queue_free()


func _apply_bounce(going: Vector2) -> void:
	linear_velocity = going.normalized() * speed
	rotation = going.angle()


func Decide_Vel(Current_Vel, mirror):
	var mirror_dir = mirror.mirror_dir

	if Current_Vel.x > 0:
		if mirror_dir == 2:
			return Vector2.DOWN
		if mirror_dir == 3:
			return Vector2.LEFT
		if mirror_dir == 4:
			return Vector2.UP
		else:
			queue_free()

	elif Current_Vel.x < 0:
		if mirror_dir == 6:
			return Vector2.UP
		if mirror_dir == 7:
			return Vector2.RIGHT
		if mirror_dir == 8:
			return Vector2.DOWN
		else:
			queue_free()

	elif Current_Vel.y > 0:
		if mirror_dir == 4:
			return Vector2.LEFT
		if mirror_dir == 5:
			return Vector2.UP
		if mirror_dir == 6:
			return Vector2.RIGHT
		else:
			queue_free()

	elif Current_Vel.y < 0:
		if mirror_dir == 8:
			return Vector2.RIGHT
		if mirror_dir == 1:
			return Vector2.DOWN
		if mirror_dir == 2:
			return Vector2.LEFT
		else:
			queue_free()

	return null
