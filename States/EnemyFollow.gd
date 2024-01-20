extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
@export var move_speed := 40.0
@export var attack_range := 35.0

func Physics_Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
	else:
		var target_vector = target.global_position - enemy.global_position
		var target_distance = target_vector.length()
		if 	target_distance < attack_range:
			Transitioned.emit("Attack")
		else:   
			enemy.velocity = target_vector.normalized() * move_speed
			
