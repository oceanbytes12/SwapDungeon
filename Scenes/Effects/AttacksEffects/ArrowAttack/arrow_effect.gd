extends Area2D

@export var speed = 120

var own_body
var damage
var knockback_amount

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
	if body.is_in_group("unit") and body.type != own_body.type:
		if body.has_method("take_hit"):
			var direction = Vector2.RIGHT.rotated(rotation)
			body.take_hit(own_body, damage, knockback_amount, direction)
			playsound_and_queuefree()

func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
	#$Arrow_hit_sfx.play()
	end_of_life = true

func set_params(own_body, damage, knockback_amount):
	self.own_body = own_body
	self.damage = damage
	self.knockback_amount = knockback_amount

	
