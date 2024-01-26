extends State
class_name EnemyStun

@export var own_body : CharacterBody2D
@export var stunTime := 0.5
@export var stunKnockback := 50
var stunClock
var hit_direction


func Enter():
	stunClock = stunTime
	own_body.velocity = hit_direction * stunKnockback

func Update(delta: float, _target: CharacterBody2D):
	if stunClock > 0:
		stunClock -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(delta: float, target: CharacterBody2D):
	own_body.velocity *= 0.95
