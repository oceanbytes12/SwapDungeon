extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
@export var move_speed := 40.0

var current_target : CharacterBody2D

func Physics_Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
	else:
		var target_distance = target.global_position - enemy.global_position
		
		if target_distance.length() > 35:   
			enemy.velocity = target_distance.normalized() * move_speed
		else:
			enemy.velocity = Vector2()
