extends State
class_name TriggerStateOnDamageTaken


@export var own_body : CharacterBody2D
@export var stunTime := 0.5
@export var stunKnockback := 50
@export var damageThreshold = 100
@export var transitionStateOnDamageTaken : String
var stunClock
var hit_direction
var damageTaken


func Enter(_target):
	stunClock = stunTime
	own_body.velocity = hit_direction * stunKnockback

func Update(delta: float, _target: CharacterBody2D):
	if stunClock > 0:
		stunClock -= delta
	else:
		if(damageTaken > damageThreshold):
			pass
		else:
			Transitioned.emit("Idle")

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity *= 0.95
