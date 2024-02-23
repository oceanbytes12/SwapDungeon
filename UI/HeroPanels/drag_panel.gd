extends Control

var click_offset

func _process(delta):
	global_position = get_global_mouse_position()

func _input(event):
	if event.is_action_released("LeftClick"):
		queue_free()
