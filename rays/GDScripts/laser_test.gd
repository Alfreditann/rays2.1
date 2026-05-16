extends RigidBody2D


var speed := 200
var last_hit_time := 0.0
var hit_delay := 0.2 # prevents multiple triggers per frame
var rect_shape1 = 0
var dir := Vector2.ZERO
var last_hit_mirror: Node = null  # ADD THIS
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

func _on_laser_test_area_entered(area: Area2D) -> void:
	if area.name == "speil_hitbox":
		
		var mirror = area.get_parent()
		
		if mirror == last_hit_mirror: 
			return
		last_hit_mirror = mirror  
		
		var going = Decide_Vel(linear_velocity, mirror)
		if going != null:
			dir = going
			call_deferred("_apply_bounce", going)  # setter alle verdier etter at spill-motoren er ferdig med matten sin
			
	if area.name == "hurtbox":
		queue_free()
	if area.name == "monster":
		queue_free()

func _apply_bounce(going: Vector2) -> void:
	linear_velocity = going.normalized() * speed
	rotation = going.angle()

func Decide_Vel(Current_Vel, mirror):
	var mirror_dir = mirror.mirror_dir
	#global_position = mirror.global_position | litt hacky men gjør laseren helt rigktig plasert
	
	if Current_Vel[0] > 0: #den går til høyre her
		if mirror_dir == 2: #speil står i mellom ned og venstre
			return Vector2.DOWN
		if mirror_dir == 3: #speil ser mot venstre
			return Vector2.LEFT
		if mirror_dir == 4: #speil står i mellom opp og venstre
			return Vector2.UP
		else:
			queue_free()
	elif Current_Vel[0] < 0: #den går til venstre her
		if mirror_dir == 6: #speil står i mellom opp og høyre
			return Vector2.UP
		if mirror_dir == 7: #speil ser mot høyre
			return Vector2.RIGHT
		if mirror_dir == 8: #speil står i mellom ned og høyre
			return Vector2.DOWN
		else:
			queue_free()
	elif Current_Vel[1] > 0: #den går ned her
		if mirror_dir == 4: #speil står i mellom opp og venstre
			return Vector2.LEFT
		if mirror_dir == 5: #speil ser opp
			return Vector2.UP
		if mirror_dir == 6: #speil står i mellom opp og høyre
			return Vector2.RIGHT
		else:
			queue_free()
	elif Current_Vel[1] < 0: #den går opp her
		if mirror_dir == 8: #speil står i mellom ned og høyre
			return Vector2.RIGHT
		if mirror_dir == 1: #speil ser ned her
			return Vector2.DOWN
		if mirror_dir == 2: #speil står i mellom ned og venstre
			return Vector2.LEFT
		else:
			queue_free()
	pass
