extends State
class_name MinotaurBoulderThrow

signal BoulderThrow

@export var own_body : CharacterBody2D
@export var timeout := 2.0
@export var knockback = 60
@export var damage = 40
#@export var boulder : # The boulder .tscn to instantiate
var timeout_timer


func Enter(_target):
	print("MinotaurBoulderThrow entered")
	emit_signal("BoulderThrow") #Can't play the animation(s) here, emit signal instead
	# At end of animation, spawn boulder:
	#var boulder = Instantiate(boulderThrowAttack)
	#boulder.setDamage(damage, knockback)?
	timeout_timer = timeout


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		return
		#Transitioned.emit("MinotaurFollow")

func Physics_Update(_delta: float, target: CharacterBody2D):
	pass
	#if target:
		## Rush towards target
		#var target_vector = target.global_position - own_body.global_position
		#own_body.velocity = target_vector.normalized() * chargeSpeed
		
		# How to deal damage to collided with objects?
		
		#var target_distance = target_vector.length()
		#if 	target_distance < own_body.weaponRange:
			#Transitioned.emit("Attack")
		#else:
			#own_body.velocity = target_vector.normalized() * own_body.runSpeed
