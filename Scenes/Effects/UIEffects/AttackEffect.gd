extends AnimatedSprite2D


func _ready():
	play("Attack")


func _on_animation_finished():
	queue_free()
