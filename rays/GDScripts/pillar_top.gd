extends StaticBody2D

var opened := false

func _process(_delta: float) -> void:
	if not opened and "key" in Global.keyFounded:
		opened = true
		open_pillar()

func open_pillar() -> void:
	print("Opening pillar")

	$AnimatedSprite2D.play("Pillar decending top")

	await $AnimatedSprite2D.animation_finished

	queue_free()
