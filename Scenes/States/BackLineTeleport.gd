extends CDState
const globals = preload("res://Scenes/UI/UIScripts/globals.gd")

@export var FailState : String
@export var SuccessState : String
@export var CooldownState : String
@export var FadeAnimator : AnimationPlayer
@export var overshoot : float = 50
var isFaded
var target
var _own_body
func Enter(_own_body, _current_target, _target_list):
	self._own_body = _own_body
	

func Update(delta, _own_body, current_target, _target_list, walk_target):
	if(isFaded):
		return
	
	if(_is_cooling_down()):
		ChangeState.emit(CooldownState, current_target, walk_target)
	elif(_target_list.is_empty()):
		ChangeState.emit(FailState, current_target, walk_target)
	else:
		target =  globals.farthest_target(_target_list.values(), _own_body.global_position)
		if(is_instance_valid(target)):
			isFaded = true
			PlayTeleportAnimation()
		else: 
			ChangeState.emit(FailState, current_target, walk_target)

func PlayTeleportAnimation():
	FadeAnimator.play("FadeOut")
	
func FinishTeleport():
	FadeAnimator.play("FadeIn")
	isFaded = false
	_reset_cooldown()
	var TeleportPoint = target.position 
	var teleport_dir = (target.position-_own_body.position).normalized()
	TeleportPoint = TeleportPoint + teleport_dir * overshoot
	
	_own_body.position = TeleportPoint 
	ChangeState.emit(SuccessState, target, null)
