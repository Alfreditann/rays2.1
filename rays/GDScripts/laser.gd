extends Area2D

var init_range = 5

var player = preload("res://Scenes/Player.tscn")
var dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("laser pos: ", position)
	print("laser dir: ", dir)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
