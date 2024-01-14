extends CharacterBody2D

@export var speed = 100
@onready var attackScene = preload("res://Scene/slash_attack_effect.tscn")
var idle = true

func _physics_process(_delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var attack = Input.is_action_just_pressed("ui_accept")
	var direction = Vector2(direction_x, direction_y).normalized()
	
	if idle and direction != Vector2.ZERO:
		$AnimationPlayer.play("Walk")
		idle = false
	elif direction == Vector2.ZERO and idle == false:
		idle = true
		$AnimationPlayer.play("Idle")
	if attack:
		$AnimationPlayer.play("Slash")
		var attackNode = attackScene.instantiate()
		attackNode.global_position = $AttackPosition.global_position
		get_parent().add_child(attackNode)
		
	
	

	velocity = direction * speed
	move_and_slide()
