extends State

@export var recovery_rate : float = 0.5
@export var damage_to_stun : float = 50
@export var stun_time := 0.5
var stun_clock : float = 0
var damage_accrued : float = 0

func Update(delta,_own_body, current_target, _target_list, walk_target):
	stun_clock -= delta
	if stun_clock <= 0:
		ChangeState.emit("Idle", current_target, walk_target)


func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity *= 0.95

func _process(delta):
	damage_accrued = clamp(damage_accrued-(recovery_rate*delta), 0, damage_to_stun+1) # a is 20
	#print("Accrued Damage: " + str(damage_accrued) + "stun clock: " + str(stun_clock))
	
func handle_hit(own_body, _damage, knockback_amount, 
				knockback_direction, _freeze, current_target, walk_target):
	

	#Always get knockbacked
	knockback_amount = knockback_amount
	knockback_direction = knockback_direction
	own_body.velocity = knockback_direction * knockback_amount
	
	#Donnot accrue stun damage if we are stunned.
	if(stun_clock <= 0):
		damage_accrued = damage_accrued + _damage
	
	#If we have taken enough damage recently
	#Setup a stun and reset damage accrued.
	if(damage_accrued > damage_to_stun):
		stun_clock = stun_time
		damage_accrued = 0
		ChangeState.emit("Stun", current_target, walk_target)
