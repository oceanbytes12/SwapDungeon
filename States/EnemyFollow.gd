extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
@export var player: CharacterBody2D

func Enter():
	pass

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 35:   
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
