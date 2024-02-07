extends Area2D

var source_team_color
var target
var damage = 40

func _ready():
	global_position = target.global_position
	rotation = 0

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
	elif body.is_in_group("unit") and body.teamColor == source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, -20, 0)



func _on_animated_sprite_2d_animation_finished():
	queue_free()
