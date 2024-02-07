extends Area2D

var source_team_color
@export var speed = 120
#@export var arrow_hit_scene : PackedScene
var target
var damage = 30

var end_of_life = false
var eol_timer = 2

func _ready():
	#$Arrow_shoot_sfx.play()
	$Arrow_shoot.post_event()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	# Countdown to queue_free()
	if (end_of_life):
		eol_timer = eol_timer - delta
		if eol_timer <= 0: 
			queue_free()

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
			#var soundnode = arrow_hit_scene.instantiate()
			#get_parent().add_child(soundnode)
			playsound_and_queuefree()
			#$Arrow_hit_sfx.play()
			#queue_free()

func playsound_and_queuefree():
	# Play sfx and start countdown timer to queue_free()
	# Turn invisible, disable any colliders
	$CollisionShape2D.set_deferred("disabled", true)
	visible = false
	#$Arrow_hit_sfx.play()
	$Arrow_hit.post_event()
	end_of_life = true
	
