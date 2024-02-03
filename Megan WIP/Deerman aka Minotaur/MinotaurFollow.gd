extends State
class_name MinotaurFollow

@export var own_body : CharacterBody2D
@export var timeout := 8.0

@export var meleeRange: float = 20
@export var AOERange: float = 30
@export var chargeRange: float = 80
@export var boulderRange: float = 120

var timeout_timer


func Enter(_target):
	timeout_timer = timeout


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		var target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		print("target distance = " + str(target_distance))
		
		if target_distance < meleeRange:
			#Transitioned.emit("Attack")
			Transitioned.emit("MinotaurMelee")
			print("Transition to MinotaurMelee")
		elif target_distance < AOERange:
			#Transitioned.emit("Attack")
			Transitioned.emit("MinotaurAOE")
			print("Transition to MinotaurAOE")
		elif target_distance < chargeRange:
			#Transitioned.emit("Attack")
			Transitioned.emit("MinotaurCharge")
			print("Transition to MinotaurCharge")
		# No animation for boulder throw yet
		#elif target_distance < boulderRange:
			##Transitioned.emit("Attack")
			#Transitioned.emit("MinotaurBoulderThrow")
			#print("Transition to MinotaurBoulderThrow")
		else:
			own_body.velocity = target_vector.normalized() * own_body.runSpeed
