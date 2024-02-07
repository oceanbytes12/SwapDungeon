extends AnimatedSprite2D


func _ready():
	play("Click")


func _on_animation_finished():
	queue_free()
