extends AkEvent2D
signal hit


func _on_mager_hit():
	$Skeleton_hit.post_event()

func _on_roguer_hit():
	$Skeleton_hit.post_event()

func _on_ranger_hit():
	$Skeleton_hit.post_event()
	
