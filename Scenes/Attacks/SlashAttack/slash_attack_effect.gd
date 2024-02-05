extends AnimatedSprite2D

var source_team_color
var target
var damage = 20


func _on_animation_finished():
	#$Sword_whoosh_sfx.play()
	queue_free()


func _on_area_2d_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage) 
			$Sword_hit_sfx.play()
			#$Sword_hit.post_event()
			#$Sword_whoosh.post_event()
