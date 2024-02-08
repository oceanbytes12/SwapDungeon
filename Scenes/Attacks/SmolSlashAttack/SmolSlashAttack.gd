extends AnimatedSprite2D

var source_team_color
var target
var damage = 20
var hitstun = 30
@export var secondSlash : PackedScene

func _on_animation_finished():
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	visible = false
	$Timer.start()


func _on_area_2d_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage, 30)
			#$Rogue_stab_sfx.play()
			$Rogue_stab.post_event()
func _on_timer_timeout():
	# summon second hit
	if target:
		look_at(target.global_position)
	var attackNode = secondSlash.instantiate()
	attackNode.global_position = $SecondHitSpawn.global_position
	attackNode.rotation = rotation
	attackNode.source_team_color = source_team_color
	attackNode.target = target
	attackNode.damage = damage-10
	get_parent().add_child(attackNode)
	queue_free()
