extends State
class_name BaseApproach

@export var timeout := 10.0

var timeout_timer
var weapon_range : float
var speed = 0

func Enter(_own_body, _current_target, _target_list):
	timeout_timer = timeout


func Update(delta, _own_body, current_target, _target_list, walk_target):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		ChangeState.emit("Idle", current_target, walk_target)

func Physics_Update(_delta, own_body, current_target, _target_list, walk_target):
	if current_target:
		var target_vector = current_target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < weapon_range:
			ChangeState.emit("Attack", current_target, walk_target)
		else:
			own_body.velocity = target_vector.normalized() * speed
	else:
		ChangeState.emit("Idle", current_target, walk_target)

func set_weapon_range(new_weapon_range):
	self.weapon_range = new_weapon_range
