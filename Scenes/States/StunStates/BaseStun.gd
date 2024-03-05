extends State
class_name BaseStun
@export var knockback_multiplier = 1
@export var stun_time := 0.5
var stun_clock

func Update(delta,_own_body, current_target, _target_list, walk_target):
	if stun_clock > 0:
		stun_clock -= delta
	else:
		ChangeState.emit("Idle", current_target, walk_target)

func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity *= 0.95

func handle_hit(own_body, _damage, knockback_amount, 
				knockback_direction, _freeze, current_target, walk_target):
	knockback_amount = knockback_amount * knockback_multiplier
	knockback_direction = knockback_direction
	stun_clock = stun_time
	own_body.velocity = knockback_direction * knockback_amount
	
	ChangeState.emit("Stun", current_target, walk_target)
