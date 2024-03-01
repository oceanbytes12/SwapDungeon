extends State
class_name BaseAttack
signal Attacked

var weapon_cooldown: float
var can_attack = true
var range_buffer = 4 # This is to prevent jittering between follow and attack states
var weapon_range : float


func Update(_delta, own_body, current_target, _target_list, walk_target):
	if not current_target:
		ChangeState.emit("Idle", current_target, walk_target)
	else:
		var target_vector = current_target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if target_distance > weapon_range + range_buffer:
			ChangeState.emit("Approach", current_target, walk_target)
		if can_attack:
			can_attack = false
			Attacked.emit(current_target)
			$CoolDownTimer.wait_time = weapon_cooldown
			$CoolDownTimer.start()

func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity = Vector2.ZERO
	
	
func _on_cool_down_timer_timeout():
	can_attack = true

func set_cooldown(cooldown):
	weapon_cooldown = cooldown
	
func set_weapon_range(new_weapon_range):
	self.weapon_range = new_weapon_range
