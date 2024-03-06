extends State
class_name BaseIdle
	
@export var ApproachState : String = "Approach"
func Update(_delta, own_body, current_target, target_list, walk_target):
	if walk_target != Vector2.ZERO:
		ChangeState.emit("Walk", null, walk_target)
	elif current_target:
		ChangeState.emit(ApproachState, current_target, walk_target)
	elif not target_list.is_empty():
		var new_target = find_closest_target(target_list, own_body)
		ChangeState.emit(ApproachState, new_target, walk_target)

func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity = Vector2.ZERO
