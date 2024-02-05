extends Sprite2D

var speed = 30

var end_of_life = false
var eol_timer = 2

func set_damage_text(text):
	$Label.text = str(text)
	

func _ready():
	$AnimatedSprite2D.play()
	#$Priest_spell_hit_sfx.play()
	#$Timer.start()
#
#func _on_timer_timeout():
	#queue_free()

func _physics_process(delta):
	position.y -= speed*delta
	
	# Countdown to queue_free()
	if (end_of_life):
		eol_timer = eol_timer - delta
		if eol_timer <= 0: 
			queue_free()
			
	
func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	visible = false
	#$Priest_spell_hit_sfx.play()
	end_of_life = true


func _on_animated_sprite_2d_animation_finished():
	#queue_free()
	playsound_and_queuefree()
