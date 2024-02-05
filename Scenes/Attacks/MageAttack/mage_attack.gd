extends Area2D

var source_team_color
@export var speed :float
var target
var turn_speed = 0.5
var damage = 40

func _ready():
	$AnimatedSprite2D.play("Spell")
	$Necro_cast_sfx.play()
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		rotate(-PI/5)
	else:
		rotate(PI/5)
	

func _physics_process(delta):
	var goal_rotation = position.angle_to_point(target.position)
	var diff_rotation = angle_to_angle(rotation, goal_rotation)
	if diff_rotation > 0:
		rotate(turn_speed*delta)
	else:
		rotate(-turn_speed*delta)
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
			$Necro_spell_hit_sfx.play()
			queue_free()

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
