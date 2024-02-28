extends Area2D

var source_team_color
var speed = 120
var target
var turn_speed = 1
var damage = 50

var end_of_life = false
var eol_timer = 2

func _ready():
	$AnimatedSprite2D.play("VineSpell")
	$Vine_launch_sfx.play()
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
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		$AnimatedSprite2D.flip_v = false
	else:
		$AnimatedSprite2D.flip_v = true
	position += direction * speed * delta
	
	# Countdown to queue_free()
	if (end_of_life):
		eol_timer = eol_timer - delta
		if eol_timer <= 0: 
			queue_free()
	

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		# If available, Call special take_hit fxn that can account for slowdown.
		if body.has_method("take_hit_with_slowdown"):
			body.take_hit_with_slowdown(global_position, damage, true)
			playsound_and_queuefree()
		# Otherwise do regular take_hit
		elif body.has_method("take_hit"):
			body.take_hit(global_position, damage)
			playsound_and_queuefree()

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
	
func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
	$Vine_hit_sfx.play()
	end_of_life = true
