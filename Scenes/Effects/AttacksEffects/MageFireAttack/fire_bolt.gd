extends Area2D

var own_body
var damage
var knockback_amount
var source_type
var speed = 100
var turn_speed = 1
var target = null

var end_of_life = false
var eol_timer = 2

func _ready():
	$AnimatedSprite2D.play()
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

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI

func set_params(new_own_body, new_damage, new_knockback_amount, target=null):
	self.target = target
	self.own_body = new_own_body
	self.damage = new_damage
	self.knockback_amount = new_knockback_amount
	self.source_type = self.own_body.type


func _on_area_entered(area):
	# Check if hitting self or friend
	var parent_node = area.get_parent()
	if parent_node.is_in_group("unit") and parent_node.type != source_type:
		if parent_node.has_method("take_hit"):
			var direction = Vector2.RIGHT.rotated(rotation)
			parent_node.take_hit(own_body, damage, knockback_amount, direction)
		queue_free()
	elif area.is_in_group("wall"):
		queue_free()
