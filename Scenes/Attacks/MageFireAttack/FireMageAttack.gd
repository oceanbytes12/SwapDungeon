extends Area2D

var source_team_color
var speed = 100
var target
var turn_speed = 1
var damage = 40

var end_of_life = false
var eol_timer = 2

func _ready():
	$AnimatedSprite2D.play()
	#$Mage_cast_sfx.play()
	$Mage_cast.post_event()
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
	
	# Countdown to queue_free()
	if (end_of_life):
		eol_timer = eol_timer - delta
		if eol_timer <= 0: 
			queue_free()

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
			playsound_and_queuefree()
	elif body.is_in_group("wall"):
		queue_free()

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI

func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
	#$Mage_spell_hit_sfx.play()
	$Mage_spell_hit.post_event()
	end_of_life = true
