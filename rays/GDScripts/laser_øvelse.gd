extends RigidBody2D

var speed = 200

@onready var sprite2D = $Sprite2D

func _ready() -> void:
	linear_velocity = Vector2.RIGHT.rotated(rotation) * speed
	gravity_scale = 0
	angular_velocity = 0
	lock_rotation = true
	sleeping = false
	
func start_moving():
	linear_velocity = Vector2.RIGHT.rotated(rotation).normalized() * speed
	sleeping = false
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
