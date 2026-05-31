extends StaticBody2D

@export var mirror_dir = 1
@onready var Sprite = $Sprite

var player_close = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate_mirror()

	var player = get_node_or_null("/root/Node2D/player")
	if player == null:
		print("Player not found in scene tree!")
		return

	player.interact.connect(_on_interact)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact():
	if not player_close:
		return
	if mirror_dir != 8:
		mirror_dir += 1
	else: 
		mirror_dir = 1
	rotate_mirror()

func rotate_mirror():
	print('rotation_',mirror_dir)
	Sprite.play("rotation_" + str(mirror_dir))


func _on_speil_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_close = true


func _on_speil_hitbox_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_close = false
