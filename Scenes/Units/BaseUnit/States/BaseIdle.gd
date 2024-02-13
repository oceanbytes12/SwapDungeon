extends State
class_name BaseIdle
	
func Update(_delta, own_body, current_target, target_list):
	if current_target:
		ChangeState.emit("Approach", current_target)
	elif not target_list.is_empty():
		var new_target = find_closest_target(target_list, own_body)
		ChangeState.emit("Approach", new_target)

func Physics_Update(_delta, own_body, _current_target, _target_list):
	own_body.velocity = Vector2.ZERO
