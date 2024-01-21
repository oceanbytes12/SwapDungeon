extends State
class_name EnemyStun

@export var enemy : CharacterBody2D
@export var stunTime := 2.0
@export var stunKnockback := 50
var stunClock
var direction


func Enter():
	stunClock = stunTime
	enemy.velocity = direction * stunKnockback

func Update(delta: float, _target: CharacterBody2D):
	if stunClock > 0:
		stunClock -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(delta: float, target: CharacterBody2D):
	enemy.velocity *= 0.95
