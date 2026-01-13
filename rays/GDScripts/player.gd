extends CharacterBody2D

const tile_size: Vector2 = Vector2(32,32)

@onready var anim = $AnimatedSprite2D

var target_pos: Vector2
var moving := false
var last_dir := Vector2.DOWN # default facing down

func _physics_process(delta: float) -> void:
	if not moving:
		read_input()

func read_input():
	var dir := Vector2.ZERO
	
	# Tile-based movement input + collision check
	if Input.is_action_pressed("move_up") and !$up.is_colliding():
		dir = Vector2.UP
	elif Input.is_action_pressed("move_down") and !$down.is_colliding():
		dir = Vector2.DOWN
	elif Input.is_action_pressed("move_left") and !$left.is_colliding():
		dir = Vector2.LEFT
	elif Input.is_action_pressed("move_rigth") and !$right.is_colliding():
		dir = Vector2.RIGHT
	
	# Update last_dir when pressing movement keys
	if dir != Vector2.ZERO:
		last_dir = dir
		start_move(dir)
		match dir:
			Vector2.UP:
				anim.play("Back")
			Vector2.DOWN:
				anim.play("Front")
			Vector2.LEFT:
				anim.play("Left")
			Vector2.RIGHT:
				anim.play("Right")
	else:
		# No tile movement, check arrow keys for idle facing
		if Input.is_action_just_pressed("ui_up"):
			last_dir = Vector2.UP
		elif Input.is_action_just_pressed("ui_down"):
			last_dir = Vector2.DOWN
		elif Input.is_action_just_pressed("ui_left"):
			last_dir = Vector2.LEFT
		elif Input.is_action_just_pressed("ui_right"):
			last_dir = Vector2.RIGHT
		
		# Play idle based on last_dir
		match last_dir:
			Vector2.UP:
				anim.play("Back_idle")
			Vector2.DOWN:
				anim.play("Front_idle")
			Vector2.LEFT:
				anim.play("Left_idle")
			Vector2.RIGHT:
				anim.play("Rigth_idle")

func start_move(dir: Vector2):
	moving = true
	target_pos = global_position + dir * tile_size

	var tween := create_tween()
	tween.tween_property(
		self,
		"global_position",
		target_pos,
		0.18
	)

	tween.finished.connect(func():
		global_position = target_pos
		moving = false
	)
