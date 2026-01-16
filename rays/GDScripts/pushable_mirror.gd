extends RigidBody2D

@onready var rayleft = $Rayleft
@onready var rayright = $Rayright

func _integrate_forces(state:) -> void:
	var velocity = state.get_linear_velocity()
	
	var hit_left = rayleft.is_colliding()
	var hit_right = rayright.is_colliding()
	
	if (hit_left and velocity.x < 0) or (hit_right and velocity.x > 0):
		velocity.x = 0
		
	velocity.y = 0
	state.set_linear_velocity(velocity)
