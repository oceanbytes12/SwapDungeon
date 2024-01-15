extends CharacterBody2D


@export var speed = 200
var idle = true

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


	velocity = direction * speed
	move_and_slide()
