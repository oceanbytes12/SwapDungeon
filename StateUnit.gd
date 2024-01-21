extends CharacterBody2D

@onready var attackPostion = $AttackCenter/AttackPoint
@onready var attackScene = preload("res://Scene/slash_attack_effect.tscn")

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
	get_parent().add_child(attackNode)

