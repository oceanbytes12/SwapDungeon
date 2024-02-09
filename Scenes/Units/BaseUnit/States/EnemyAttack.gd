extends State
class_name EnemyAttack
signal Attacked

var weaponCooldown: float = 1.5
var can_attack = true
var range_buffer = 4 # This is to prevent jittering between follow and attack states
var weapon_range = 40


func Update(_delta, own_body, current_target, target_list):
	if not current_target:
		ChangeState.emit("Idle", current_target)
	else:
		var target_vector = current_target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if target_distance > weapon_range + range_buffer:
			ChangeState.emit("Follow", current_target)
		if can_attack:
			can_attack = false
			Attacked.emit()
			print("ATTAck")
			$CoolDownTimer.wait_time = weaponCooldown
			$CoolDownTimer.start()

func Physics_Update(_delta, own_body, _current_target, _target_list):
	own_body.velocity = Vector2.ZERO
	
	
func _on_cool_down_timer_timeout():
	can_attack = true
