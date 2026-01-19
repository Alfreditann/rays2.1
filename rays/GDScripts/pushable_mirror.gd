extends RigidBody2D

@onready var ray_left = $Rayleft
@onready var ray_right = $Rayright
var freeze_delay = 0.0
var FREEZE_DELAY_TIME := 0.15

func _physics_process(delta: float) -> void:
	var player_detected := false
	
	if ray_left.is_colliding():
		var collider = ray_left.get_collider()
		if collider and collider.is_in_group("player"):
			player_detected = true
			
	if ray_right.is_colliding():
		var collider = ray_right.get_collider()
		if collider and collider.is_in_group("player"):
			player_detected = true
	
	if player_detected:
		freeze_delay = FREEZE_DELAY_TIME
		if freeze:
			set_deferred("freeze", false)
	else:
		freeze_delay -= delta
		if freeze_delay <= 0.0 and not freeze:
			set_deferred("freeze", true)
			set_deferred("freeze_mode", RigidBody2D.FREEZE_MODE_STATIC)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
