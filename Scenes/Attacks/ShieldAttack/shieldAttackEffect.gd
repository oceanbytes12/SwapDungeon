extends AnimatedSprite2D

var source_team_color
var target
var damage = 20
var hitstun = 100

func _on_animation_finished():
	queue_free()

func set_knockback(knockback_amount):
	hitstun = knockback_amount


func _on_area_2d_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage, hitstun)
			#$Shield_hit_sfx.play()
			$Shield_hit.post_event()
