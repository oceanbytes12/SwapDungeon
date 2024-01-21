extends CharacterBody2D

@onready var attackPostion = $AttackCenter/AttackPoint
@onready var attackScene = preload("res://Scene/slash_attack_effect.tscn")
signal Hit

func _process(_delta):
	var target = $SM.current_target
	if target:
		$AttackCenter.look_at(target.global_position)

func _physics_process(_delta):
	move_and_slide()

func _on_attack_attacked():
	var attackNode = attackScene.instantiate()
	attackNode.global_position = attackPostion.global_position
	attackNode.rotation = $AttackCenter.rotation
	attackNode.source_groups = get_groups()
	get_parent().add_child(attackNode)

func take_hit(hit_position):
	print(name)
	var direction = (global_position-hit_position).normalized()
	Hit.emit(direction)
	$AnimationPlayer.play("hitAnimation")
	#$AnimationPlayer.play("HeadPop")
