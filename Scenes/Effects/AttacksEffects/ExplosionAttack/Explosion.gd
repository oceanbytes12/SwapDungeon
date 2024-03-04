extends Area2D

var target
var damage 
var own_body
var knockback_amount
var source_type

func set_transform_params(global_position, rotation):
	pass

func set_params(new_own_body, new_damage, new_knockback_amount, target=null):
	self.target = target
	self.own_body = new_own_body
	self.damage = new_damage
	self.knockback_amount = new_knockback_amount
	self.source_type = self.own_body.type
	self.global_position = new_own_body.global_position

func _ready():
	$AnimatedSprite2D.play("LargeHolySpell")
	rotation = 0
	

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit"):
		if body.has_method("take_hit"):
			print("Explosion Hit: " + body.name)
			#if(body.type != source_type):
			var direction = Vector2.RIGHT.rotated(rotation)
			body.take_hit(own_body, damage, knockback_amount, direction)
			



func _on_animated_sprite_2d_animation_finished():
	queue_free()
