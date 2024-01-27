extends State
class_name EnemyIdle

@export var own_body: CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
func Enter(_target):
	randomize_wander()

func Update(delta: float, target: CharacterBody2D):
	if target:
		Transitioned.emit("Follow")
	else:
		if wander_time > 0:
			wander_time -= delta
		else:
			randomize_wander()

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = move_direction.normalized() * own_body.walkSpeed
