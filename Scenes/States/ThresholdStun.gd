extends State
class_name TriggerStateOnDamageTaken


@export var own_body : CharacterBody2D
@export var stunTime := 0.5
@export var threshold_state : String
var stun_clock
var hit_direction

@export var damageTaken = 0
@export var damageThreshold = 100

func Update(delta,_own_body, current_target, _target_list, walk_target):
	if(damageTaken > damageThreshold):
		damageTaken = 0
		ChangeState.emit(threshold_state, current_target, walk_target)
		return
	
	if stun_clock > 0:
		stun_clock -= delta
	else:
		ChangeState.emit("Idle", current_target, walk_target)
			
#Happens whenever we take damage
func trigger_stun(own_body, _damage, knockback_amount, knockback_direction, _freeze):
	knockback_amount = knockback_amount
	knockback_direction = knockback_direction
	stun_clock = stunTime
	own_body.velocity = knockback_direction * knockback_amount
	damageTaken = damageTaken + _damage
	
func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity *= 0.95
