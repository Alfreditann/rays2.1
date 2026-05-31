extends Area2D


func _on_area_entered(area: Area2D) -> void:
	print("Entered area:", area.name)

	if area.get_parent().is_in_group("laser"):
		print("key found!")


		if !"key" in Global.keyFounded:
			Global.keyFounded.append("key")

	$"../AnimatedSprite2D".play("key")

	await $"../AnimatedSprite2D".animation_finished
	$"../AnimatedSprite2D".play("spin")
