extends RigidBody2D

var opened = false


func _process(delta: float) -> void:
	if "key" in Global.keyFounded:
		open_pillar()


func open_pillar() -> void:
	print("hei")
	$AnimationPlayer.play("pillar_anim")
	await $AnimationPlayer.animation_finished
	queue_free()
