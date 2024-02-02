extends State
class_name BossWindup

@export var own_body : CharacterBody2D
@export var timeout := 3.0
var timeout_timer


func Enter(_target):
	timeout_timer = timeout


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")
		# From here, need to transition to whichever attack comes next.

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		pass
		# Stay in place, rotate to follow the direction of the target
		#look_at(target.global_position) #fxn not found in base self cuz state is not a Node2D
		#
		#interpolation code idea:
		#var angle = (target - self.global_position).angle()
		#self.global_rotation = lerp_angle(self.global_rotation, angle, delta)

		# old follow enemy code:
		#var target_vector = target.global_position - own_body.global_position
		#var target_distance = target_vector.length()
		#if 	target_distance < own_body.weaponRange:
			#Transitioned.emit("Attack")
		#else:
			#own_body.velocity = target_vector.normalized() * own_body.runSpeed
