extends Area2D

@export var key_id := "key1"

func _on_area_entered(area: Area2D) -> void:
	print("Entered area:", area.name)

	if area.get_parent().is_in_group("laser"):
		print("key found!")

		if key_id not in Global.keyFounded:
			Global.keyFounded.append(key_id)

		$"../AnimatedSprite2D".play("key")

		await $"../AnimatedSprite2D".animation_finished

		$"../AnimatedSprite2D".play("spin")
