extends State
class_name EnemyStun

@export var stun_time := 0.5
var knockback_amount
var knockback_direction
var stun_clock

func Enter(own_body, _current_target, _target_list):
	stun_clock = stun_time
	own_body.velocity = knockback_direction * knockback_amount

func Update(delta,_own_body, current_target, _target_list):
	if stun_clock > 0:
		stun_clock -= delta
	else:
		ChangeState.emit("Idle", current_target)

func Physics_Update(delta, own_body, _current_target, _target_list):
	own_body.velocity *= 0.95

func set_stun_params(damage, knockback_amount, knockback_direction, freeze):
	knockback_amount = knockback_amount
	knockback_direction = knockback_direction
