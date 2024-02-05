extends Area2D


@export var own_body : CharacterBody2D
@export var damage : int = 40

func _on_body_entered(body):
	if body.is_in_group("unit") and body.teamColor != own_body.teamColor:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage, 1000)
