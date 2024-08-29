extends Control

var click_offset = Vector2(0, 0)

func _process(delta):
	global_position = get_global_mouse_position() - click_offset

func _input(event):
	if event.is_action_released("LeftClick"):
		queue_free()
