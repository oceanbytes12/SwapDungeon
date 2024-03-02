extends Area2D

@export var speed = 120

var own_body
var damage
var knockback_amount
var source_type

var end_of_life = false
var eol_timer = 2


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	# Countdown to queue_free()
	if (end_of_life):
		eol_timer = eol_timer - delta
		if eol_timer <= 0: 
			queue_free()

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.type != source_type:
		if body.has_method("take_hit"):
			var direction = Vector2.RIGHT.rotated(rotation)
			body.take_hit(own_body, damage, knockback_amount, direction)
		queue_free()

func set_params(new_own_body, new_damage, new_knockback_amount, target):
	self.own_body = new_own_body
	self.damage = new_damage
	self.knockback_amount = new_knockback_amount
	self.source_type = self.own_body.type

	
