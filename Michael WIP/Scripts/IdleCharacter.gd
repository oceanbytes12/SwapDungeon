extends Control


# Called when the node enters the scene tree for the first time.
func _animate():
	$Animator.set_active(true)
	$Animator.play("Walk")
