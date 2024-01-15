extends CharacterBody2D

@export var speed = 100
@onready var attackScene = preload("res://Scene/slash_attack_effect.tscn")
var idle = true
var state = "idle"
var target = null
var can_slash = true

func _physics_process(_delta):
	#var direction_x = Input.get_axis("ui_left", "ui_right")
	#var direction_y = Input.get_axis("ui_up", "ui_down")
	#var attack = Input.is_action_just_pressed("ui_accept")
	#var direction = Vector2(direction_x, direction_y).normalized()
	#
	#if idle and direction != Vector2.ZERO:
		#$AnimationPlayer.play("Walk")
		#idle = false
	#elif direction == Vector2.ZERO and idle == false:
		#idle = true
		#$AnimationPlayer.play("Idle")
	#if attack:
		#$AnimationPlayer.play("Slash")
		#var attackNode = attackScene.instantiate()
		#attackNode.global_position = $AttackPosition.global_position
		#get_parent().add_child(attackNode)
	var direction = Vector2.ZERO
	if state == "idle":
		direction = Vector2.ZERO
	elif state == "attack":
		var target_dis = position.distance_to(target.position)
		if (direction != Vector2.ZERO):
			target.position = position
		elif target_dis > 3:
			direction = (target.position - position).normalized()
	elif state == "slash" and can_slash:
		can_slash = false
		$Timer.start()
		direction = Vector2.ZERO
		$AnimationPlayer.play("Slash")
		var attackNode = attackScene.instantiate()
		attackNode.global_position = $AttackPosition.global_position
		get_parent().add_child(attackNode)

	velocity = direction * speed
	move_and_slide()


func _on_sense_range_body_entered(body):
	if state == "idle" and body.name == "Dummy":
		target = body
		state = "attack"


func _on_attack_range_body_entered(body):
	if state == "attack" and body.name == "Dummy":
		target = body
		state = "slash"


func _on_timer_timeout():
	can_slash = true


func _on_attack_range_body_exited(body):
	state = "attack"


func _on_sense_range_body_exited(body):
	state = "idle"
