extends State
class_name ChooseTarget

@export var own_body : CharacterBody2D
@export var timeout := 3.0
var timeout_timer

# Randomly choose a target based on multiple ranges: 
#@export var meleeRange: float
#@export var AOERange: float
#@export var chargeRange: float
#@export var bolderRange: float


func Enter(_target):
	timeout_timer = timeout
	
	#From all targets in range, randomly choose one
	# Set( target)
	# Transitioned.emit("Follow")


#func Update(delta: float, _target: CharacterBody2D):
	#if timeout_timer > 0:
		#timeout_timer -= delta
	#else:
		#Transitioned.emit("Idle")
#
#func Physics_Update(_delta: float, target: CharacterBody2D):
	#if target:
		#var target_vector = target.global_position - own_body.global_position
		#var target_distance = target_vector.length()
		#if 	target_distance < own_body.weaponRange:
			#Transitioned.emit("Attack")
		#else:
			#own_body.velocity = target_vector.normalized() * own_body.runSpeed
