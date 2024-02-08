extends AkEvent2D

func _on_base_unit_hit():
	$Skeleton_hit.post_event()
	print("hit")

func _on_mager_hit():
	$Skeleton_hit.post_event()

func _on_roguer_hit():
	$Skeleton_hit.post_event()

func _on_ranger_hit():
	$Skeleton_hit.post_event()
