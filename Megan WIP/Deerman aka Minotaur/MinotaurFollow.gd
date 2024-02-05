extends State
class_name MinotaurFollow

signal Charge
signal SmashGround
signal Walk
signal Melee

@export var own_body : CharacterBody2D
@export var timeout := 8.0

@export var meleeRange: float = 20
#@export var AOERange: float = 30
#@export var chargeRange: float = 80
#@export var boulderRange: float = 120

var timeout_timer

var next_attack
enum Attacks {
	MELEE, 
	CHARGE,
	AOE,
#	BOULDER
}


func Enter(_target):
	timeout_timer = timeout
	ChooseNextAttack()
	#print(next_attack)


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")
		# Or, choose another attack and try again

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		var target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		#print("target distance = " + str(target_distance))
		
		# If we are doing a special attack, do the attack regardless of distance from target.
		# Otherwise, move closer to target until within range for melee attack
		match next_attack:
			Attacks.AOE:
				Transitioned.emit("MinotaurAOE")
				print("Transition to MinotaurAOE")
				emit_signal("SmashGround")
				
			Attacks.CHARGE:
				Transitioned.emit("MinotaurCharge")
				print("Transition to MinotaurCharge")
				emit_signal("Charge")
				
			_: # default, MELEE
				if target_distance < meleeRange:
					# We don't have a Melee animation yet
					#Transitioned.emit("MinotaurMelee")
					#print("Transition to MinotaurMelee")
					#emit_signal("Melee")
					# TEMP call AOE attack instead of melee
					Transitioned.emit("MinotaurAOE")
					print("Transition to MinotaurAOE")
					emit_signal("SmashGround")
				else:
					own_body.velocity = target_vector.normalized() * own_body.runSpeed
					emit_signal("Walk")
			

func ChooseNextAttack():
	# First choose a different target?
	
	var random = RandomNumberGenerator.new()
	random.randomize()
	var result = random.randi_range(0, 10)
	#print(random.randi_range(0, 10))
	
	if result < 3: # Charge attack
		next_attack = Attacks.CHARGE
	elif result < 6: # AOE
		next_attack = Attacks.AOE
	else: # Standard/Melee attack
		next_attack = Attacks.MELEE
