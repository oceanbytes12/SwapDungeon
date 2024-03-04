extends AnimatedSprite2D

var own_body
var damage
var knockback_amount
var source_type


func _on_animation_finished():
	queue_free()

func set_params(new_own_body, new_damage, new_knockback_amount, target):
	self.own_body = new_own_body
	self.damage = new_damage
	self.knockback_amount = new_knockback_amount
	self.source_type = self.own_body.type

func set_transform_params(global_position, rotation):
	self.rotation = rotation
	self.global_position = global_position

func _on_area_2d_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.type != source_type:
		if body.has_method("take_hit"):
			var direction = Vector2.RIGHT.rotated(rotation)
			body.take_hit(own_body, damage, knockback_amount, direction)
