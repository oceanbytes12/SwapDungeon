extends State
class_name MinotaurCharge

signal Charging

@export var own_body : CharacterBody2D
#@export var timeout := 2.0
@export var chargeSpeed = 60
#@export var knockback = 60
@export var damage = 40

@export var charge_collider : Area2D 


#var timeout_timer

var is_charging = false

#signal from art2 to here, on animation finish then transition back to Follow

func Enter(_target):
	charge_collider.disabled = true
	print("MinotaurCharge entered")
	emit_signal("Charging") #Can't play the animation(s) here, emit signal instead



#func Update(delta: float, _target: CharacterBody2D):
	## If not in range, walk towards target. Otherwise, start rush
	## Messy, cuz range needs to match
	#
	#if timeout_timer > 0:
		#timeout_timer -= delta
	#else:
		## Charge ends when timer is up
		#print("Charge attack completed")
		#return
		##Transitioned.emit("MinotaurFollow")
		##Transitioned.emit("ChooseTarget") # Choose a new target for next attack?

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target and is_charging:
		# Rush towards target
		#print("Minotaur is charging")
		var target_vector = target.global_position - own_body.global_position
		own_body.velocity = target_vector.normalized() * chargeSpeed
		

#Still need a func here tied to the collisionShape
#func on_collision_detected
	#do stuff
	#Apply knockback force, to push units out of the way

func _on_art_2_start_charge():
	is_charging = true
	charge_collider.disabled = false

func _on_art_2_end_charge():
	is_charging = false
	charge_collider.disabled = true
	
# on end of animation
func _on_art_2_charge_anim_complete():
	print("Charge attack completed")
	#Transitioned.emit("Idle")
	#Transitioned.emit("Follow")
	Transitioned.emit("Cooldown")
	#return
