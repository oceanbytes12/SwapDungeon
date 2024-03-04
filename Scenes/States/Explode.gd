extends State
class_name Animate
signal Attacked

@export var own_body : CharacterBody2D
var weapon_cooldown: float
var can_attack = true
var range_buffer = 4 # This is to prevent jittering between follow and attack states
var weapon_range : float

#ChangeState.emit("Attack", current_target, walk_target)

#func OnFinishAnimation():
	#Attacked.emit(current_target)
	#own_body.Die()

func Physics_Update(_delta, own_body, _current_target, _target_list, _walk_target):
	own_body.velocity = Vector2.ZERO
	
func _on_cool_down_timer_timeout():
	can_attack = true

func set_cooldown(cooldown):
	weapon_cooldown = cooldown
	
func set_weapon_range(new_weapon_range):
	self.weapon_range = new_weapon_range

#new_state.Enter(own_body, current_target, target_list)
func Enter(_own_body, _target, _target_list):
	Attacked.emit(_target)
	own_body.Die()
