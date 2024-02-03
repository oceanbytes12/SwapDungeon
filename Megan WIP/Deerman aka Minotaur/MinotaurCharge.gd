extends State
class_name MinotaurCharge

signal Charging

@export var own_body : CharacterBody2D
@export var timeout := 2.0
@export var chargeSpeed = 30
@export var knockback = 60
@export var damage = 40
var timeout_timer


func Enter(_target):
	print("MinotaurCharge entered")
	emit_signal("Charging") #Can't play the animation(s) here, emit signal instead
	timeout_timer = timeout


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		# Charge ends when timer is up
		print("Charge attack completed")
		return
		#Transitioned.emit("MinotaurFollow")
		#Transitioned.emit("ChooseTarget") # Choose a new target for next attack?

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		# Rush towards target
		#print("Minotaur is charging")
		var target_vector = target.global_position - own_body.global_position
		own_body.velocity = target_vector.normalized() * chargeSpeed
		
		# How to deal damage to collided with objects?
		
		#var target_distance = target_vector.length()
		#if 	target_distance < own_body.weaponRange:
			#Transitioned.emit("Attack")
		#else:
			#own_body.velocity = target_vector.normalized() * own_body.runSpeed
