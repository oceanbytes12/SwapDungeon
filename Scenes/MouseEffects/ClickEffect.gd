extends AnimatedSprite2D

#func _animation_finished():
	#queue_free()

func _ready():
	print("TEST")
