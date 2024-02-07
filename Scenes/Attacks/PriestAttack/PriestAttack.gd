extends Area2D

var source_team_color
var target
var damage = 40

var end_of_life = false
var eol_timer = 2

func _ready():
	$AnimatedSprite2D.play("HolySpell")
	#$Spell_cast_sfx.play()
	global_position = target.global_position
	rotation = 0
	
func _physics_process(delta):
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
	elif body.is_in_group("unit") and body.teamColor == source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, -20, 0)
			playsound_and_queuefree()

func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
	#$Priest_spell_hit_sfx.play()
	$Priest_spell_cast.post_event()
	end_of_life = true

func _on_animated_sprite_2d_animation_finished():
	queue_free()
