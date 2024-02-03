extends State
class_name TriggerStateOnDamageTaken


@export var own_body : CharacterBody2D
@export var stunTime := 0.5
@export var stunKnockback := 50
@export var transitionStateOnDamageTaken : String
var stunClock
var hit_direction

var damageTaken = 0
@export var damageThreshold = 100


func Enter(_target):
	stunClock = stunTime
	own_body.velocity = hit_direction * stunKnockback

func HasMetDamageThreshold():
	return damageTaken > damageThreshold

func UpdateDamage(damage):
	damageTaken = damageTaken + damage

func Update(delta: float, _target: CharacterBody2D):
	if stunClock > 0:
		stunClock -= delta
	else:
		if(HasMetDamageThreshold()):
			damageTaken = 0
			Transitioned.emit(transitionStateOnDamageTaken)
		else:
			Transitioned.emit("Idle")
			

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity *= 0.95
