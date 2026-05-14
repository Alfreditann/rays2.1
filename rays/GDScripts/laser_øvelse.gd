extends CharacterBody2D

var speed = 100

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
	
func _on_laser_area_entered(area: Area2D) -> void:
	if area.name.begins_with("speil_hitbox"):
		Vector2.RIGHT
	#if area.name == "hurtbox":
		#queue_free()
		
