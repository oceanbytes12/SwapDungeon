extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D
@export var move_speed := 40.0
@export var attack_range := 40.0

func Physics_Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
		return
	var target_vector = target.global_position - enemy.global_position
	var target_distance = target_vector.length()
	if target_distance > attack_range:
		Transitioned.emit("Follow")
	else:
		enemy.velocity = Vector2()
