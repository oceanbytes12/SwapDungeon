extends State
class_name PlayerWalk

var spot_buffer = 10
var speed = 40

func Physics_Update(_delta, own_body, current_target, _target_list, walk_target):
	if walk_target:
		var target_vector = walk_target - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < spot_buffer:
			ChangeState.emit("Idle", null, Vector2.ZERO)
		else:
			own_body.velocity = target_vector.normalized() * speed
	else:
		ChangeState.emit("Idle", current_target, walk_target)
