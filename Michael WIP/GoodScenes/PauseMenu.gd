extends Panel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
	
