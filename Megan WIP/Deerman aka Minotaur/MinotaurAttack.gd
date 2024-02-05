extends State
class_name MinotaurAttack

signal Charge
signal SmashGround
signal Walk
signal Melee

@export var own_body : CharacterBody2D
@export var timeout := 8.0
@export var meleeRange: float = 20
@export var ChargeWeight : float = 0.5
@onready var CurrentChargeWeight : float = ChargeWeight
@export var SlamWeight : float = 0.5
@onready var CurrentSlamWeight : float = SlamWeight

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

func _process(delta):
	IncreaseWeights(delta)

func IncreaseWeights(delta):
	CurrentSlamWeight = clampf(CurrentSlamWeight + delta, 0, SlamWeight)
	CurrentChargeWeight = clampf(CurrentChargeWeight + delta, 0, ChargeWeight)

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		var target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		#print("target distance = " + str(target_distance))
		
		# If we are doing a special attack, do the attack regardless of distance from target.
		# Otherwise, move closer to target until within range for melee attack
		match next_attack:
			Attacks.AOE:
				Transitioned.emit("SlamReady")
				print("Transition to MinotaurAOE")
				
			Attacks.CHARGE:
				Transitioned.emit("ChargeReady")
				print("Transition to MinotaurCharge")
				
			_: # default, MELEE
				if target_distance < meleeRange:
					Transitioned.emit("SlamReady")
					print("Transition to MinotaurAOE")

				else:
					own_body.velocity = target_vector.normalized() * own_body.runSpeed
			

func ChooseNextAttack():
	var random = RandomNumberGenerator.new()
	random.randomize()

	#print(random.randi_range(0, 10))
	if(CurrentChargeWeight > CurrentSlamWeight):
		next_attack = Attacks.CHARGE
		CurrentChargeWeight = CurrentChargeWeight * random.randf_range(0.25, 0.5)
	else:
		next_attack = Attacks.AOE
		CurrentSlamWeight = CurrentSlamWeight * random.randf_range(0.25, 0.5)
