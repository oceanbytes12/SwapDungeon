extends Area2D

var source_team_color
@export var speed = 120
var target
var damage = 30

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
			queue_free()
