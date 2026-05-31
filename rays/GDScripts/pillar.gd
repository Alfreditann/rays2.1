extends StaticBody2D

@export var key_id := "key1"

var opened := false

func _process(_delta: float) -> void:
	if not opened and key_id in Global.keyFounded:
		opened = true
		open_pillar()

func open_pillar() -> void:
	print("Opening pillar")

	$AnimatedSprite2D.play("Pilar decending bottom")

	await $AnimatedSprite2D.animation_finished

	queue_free()
