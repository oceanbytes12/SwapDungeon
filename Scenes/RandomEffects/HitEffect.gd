extends Sprite2D

var speed = 30

func set_damage_text(text):
	$Label.text = str(text)
	

func _ready():
	$AnimatedSprite2D.play()
	#$Timer.start()
#
#func _on_timer_timeout():
	#queue_free()

func _physics_process(delta):
	position.y -= speed*delta
	

func _on_animated_sprite_2d_animation_finished():
	queue_free()
