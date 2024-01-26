extends State
class_name EnemyDead

@export var own_body: CharacterBody2D

func Physics_Update(delta: float, target: CharacterBody2D):
	own_body.velocity = Vector2.ZERO
