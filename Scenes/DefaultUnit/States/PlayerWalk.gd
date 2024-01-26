extends State
class_name PlayerWalk

@export var own_body : CharacterBody2D
@export var move_speed := 40.0
@export var timeout := 3.0
@export var distance_buffer := 10.0
var target_position : Vector2
var timeout_timer : float


func Enter(_target):
	timeout_timer = timeout

func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(_delta: float, _target: CharacterBody2D):
	var target_vector = target_position - own_body.global_position
	var target_distance = target_vector.length()
	if target_distance <= distance_buffer:
		Transitioned.emit("Idle")
	else:
		own_body.velocity = target_vector.normalized() * move_speed
			
