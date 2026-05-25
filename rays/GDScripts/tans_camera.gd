extends Camera2D

const screen_size := Vector2(320,180)
var curr_screen := Vector2(0,0)

func _ready() -> void:
	set_as_top_level(true)
	global_position = get_parent().global_position
	_update_screen(curr_screen)

func _physics_process(delta: float) -> void:
	var parent_screen : Vector2 = (get_parent().global_position / screen_size).floor()
	if not parent_screen.is_equal_approx(curr_screen):
		_update_screen(parent_screen)

func _update_screen(new_screen : Vector2) -> void:
	curr_screen = new_screen
	global_position = curr_screen * screen_size + screen_size * 0.5
