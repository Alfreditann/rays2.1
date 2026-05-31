extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Entered area:", area.name)
	print("Parent:", area.get_parent().name)
	if area.get_parent().is_in_group("player"):
		print("key found!")
		Global.keyFounded.append(self.name)

		
