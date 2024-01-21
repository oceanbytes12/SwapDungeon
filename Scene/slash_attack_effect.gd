extends AnimatedSprite2D


func _on_animation_finished():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.has_method("take_hit"):
		body.take_hit(global_position)
