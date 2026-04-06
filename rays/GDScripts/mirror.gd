extends StaticBody2D

var mirror_dir = 1
@onready var Sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate_mirror()
	var player = get_node("/root/Map/player")
	player.interact.connect(_on_interact)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact():
	if mirror_dir != 8:
		mirror_dir += 1
	else: 
		mirror_dir = 1
	rotate_mirror()

func rotate_mirror():
	print('rotation_',mirror_dir)
	Sprite.play("rotation_" + str(mirror_dir))
