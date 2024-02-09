extends State
class_name EnemyDead

@export var own_body: CharacterBody2D


func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2.ZERO
	


func _on_base_unit_died():
	$Skeleton_death.post_event()


func _on_roguer_died():
	$Skeleton_death.post_event()


func _on_ranger_died():
	$Skeleton_death.post_event()


func _on_mager_died():
	$Skeleton_death.post_event()
