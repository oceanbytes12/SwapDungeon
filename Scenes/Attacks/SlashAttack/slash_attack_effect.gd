extends AnimatedSprite2D

var source_groups

func _on_animation_finished():
	queue_free()


func _on_area_2d_body_entered(body):
	# Check if hitting self or friend
	for g in source_groups:
		if body.is_in_group(g):
			return
	if body.has_method("take_hit"):
		body.take_hit(global_position)
