extends CharacterBody2D


@export var speed = 100
var idle = true
var hit = false

func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var attack = Input.is_action_just_pressed("ui_accept")
	var direction = Vector2(direction_x, direction_y).normalized()
	
	if idle and direction != Vector2.ZERO:
		#$AnimationPlayer.play("Walk")
		idle = false
	elif direction == Vector2.ZERO and idle == false:
		idle = true
		#$AnimationPlayer.play("Idle")

	if not hit:
		velocity = direction * speed
	else:
		velocity *= 0.95
	move_and_slide()

func take_hit(hit_position):
	var direction = (global_position-hit_position).normalized()
	velocity = direction * 100
	hit = true
	$StunTimer.start()
	$AnimationPlayer.play("hitAnimation")


func _on_stun_timer_timeout():
	hit= false
