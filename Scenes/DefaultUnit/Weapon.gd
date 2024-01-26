extends Marker2D
@onready var attackScene = preload("res://Scenes/Attacks/SlashAttack/slash_attack_effect.tscn")
var teamColor

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		$Art.flip_v = false
		$Art.position = $RightOffset.position
	else:
		$Art.flip_v = true
		$Art.position = $LeftOffset.position


func _on_attack_attacked():
	var attackNode = attackScene.instantiate()
	attackNode.global_position = $AttackPoint.global_position
	attackNode.rotation = rotation
	attackNode.source_team_color = teamColor
	get_parent().get_parent().add_child(attackNode)
