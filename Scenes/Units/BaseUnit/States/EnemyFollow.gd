extends State
class_name EnemyFollow

@export var timeout := 10.0

var timeout_timer
var weaponRange = 40
var speed = 40

func Enter(_own_body, _current_target, _target_list):
	timeout_timer = timeout


func Update(delta, _own_body, current_target, target_list):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		ChangeState.emit("Idle", current_target)

func Physics_Update(_delta, own_body, current_target, target_list):
	if current_target:
		var target_vector = current_target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < weaponRange:
			ChangeState.emit("Attack", current_target)
		else:
			own_body.velocity = target_vector.normalized() * speed
	else:
		ChangeState.emit("Idle", current_target)
