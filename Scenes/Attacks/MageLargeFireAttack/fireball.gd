extends Area2D

var source_team_color
var speed = 120
var target
var turn_speed = 0.5
var damage = 50

func _ready():
	$AnimatedSprite2D.play("FireBall")
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		rotate(-PI/8)
	else:
		rotate(PI/8)
	

func _physics_process(delta):
	var goal_rotation = position.angle_to_point(target.position)
	var diff_rotation = angle_to_angle(rotation, goal_rotation)
	if diff_rotation > 0:
		rotate(turn_speed*delta)
	else:
		rotate(-turn_speed*delta)
	turn_speed -= delta*0.3
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		$AnimatedSprite2D.flip_v = false
	else:
		$AnimatedSprite2D.flip_v = true
	position += direction * speed * delta

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
	elif body.is_in_group("wall"):
		queue_free()

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
