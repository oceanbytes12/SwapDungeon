extends State
class_name PlayerStand

@export var own_body: CharacterBody2D

func Update(delta: float, target: CharacterBody2D):
	if target:
		Transitioned.emit("Follow")

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2.ZERO
