extends RigidBody2D

var speed := 200
var dir := Vector2.LEFT
var last_hit_mirror: Node = null

var is_hitting := false



const TILE_SIZE := 32
var distance := 3
var tile_progress := 0.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	add_to_group("laser")

	lock_rotation = true
	angular_velocity = 0
	gravity_scale = 0

	linear_velocity = dir.normalized() * speed

	anim.animation_finished.connect(_on_anim_finished)

	update_anim()


func _physics_process(delta):
	var move_amount = speed * delta
	tile_progress += move_amount

	while tile_progress >= TILE_SIZE:
		tile_progress -= TILE_SIZE
		distance -= 1

		if distance <= 0:
			queue_free()


func _on_laser_test_area_entered(area: Area2D) -> void:
	if area.name == "speil_hitbox":
		var mirror = area.get_parent()
		
		mirror.play_hit_sound()

		if mirror == last_hit_mirror:
			return

		last_hit_mirror = mirror
		distance += 3

		var going = Decide_Vel(linear_velocity, mirror)

		if going == null:
			queue_free()
			return

		play_hit_anim_from_dir(going)

		dir = going
		_apply_bounce(going)

	if area.name in ["hurtbox", "monster"]:
		queue_free()


func _apply_bounce(going: Vector2) -> void:
	linear_velocity = going.normalized() * speed
	update_anim()


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


func update_anim():
	if is_hitting:
		return

	var v = linear_velocity.normalized()

	if abs(v.x) > abs(v.y):
		if v.x > 0:
			anim.play("right")
		else:
			anim.play("left")
	else:
		if v.y > 0:
			anim.play("down")
		else:
			anim.play("up")


func play_hit_anim_from_dir(v: Vector2):
	if v == Vector2.ZERO:
		return

	is_hitting = true

	v = v.normalized()

	if abs(v.x) > abs(v.y):
		if v.x > 0:
			anim.play("hit_right")
		else:
			anim.play("hit_left")
	else:
		if v.y > 0:
			anim.play("hit_down")
		else:
			anim.play("hit_up")


func _on_anim_finished():
	if anim.animation.begins_with("hit"):
		is_hitting = false
		update_anim()
