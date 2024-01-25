extends State
class_name EnemyFollow

@export var own_body : CharacterBody2D
@export var move_speed := 40.0
@export var attack_range := 35.0
@export var timeout := 3.0
var timeout_timer


func Enter():
	timeout_timer = timeout

func Update(delta: float, target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
	else:
		var target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < attack_range:
			Transitioned.emit("Attack")
		else:   
			own_body.velocity = target_vector.normalized() * move_speed
			
