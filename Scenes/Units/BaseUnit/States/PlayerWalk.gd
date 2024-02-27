extends State
class_name PlayerWalk

@export var timeout := 10.0

var timeout_timer
var spot_buffer = 2
var speed = 40

func Enter(_own_body, _current_target, _target_list):
	timeout_timer = timeout


func Update(delta, _own_body, current_target, target_list, walk_target):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		ChangeState.emit("Idle", current_target)

func Physics_Update(_delta, own_body, current_target, _target_list, walk_target):
	if walk_target:
		var target_vector = walk_target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < spot_buffer:
			ChangeState.emit("Idle", current_target)
		else:
			own_body.velocity = target_vector.normalized() * speed
	else:
		ChangeState.emit("Idle", current_target)
