extends Area2D

var tween : Tween
var drop_target
var damage
var source_type
var dropping
var fallDuration = 1
var own_body

@export var Animator : AnimationPlayer
@export var start_position : float
@export var xrange : int

func set_transform_params(global_position, rotation):
	pass

func set_params(new_own_body, new_damage, new_knockback_amount, target=null):
	own_body = new_own_body
	drop_target = target
	damage = new_damage
	source_type = new_own_body.type
	if(drop_target):
		global_position = drop_target.global_position
		global_position.y = start_position
		global_position.x = global_position.x + randf_range(-xrange, xrange)
	Animator.play("ice_build")
	

func drop():
	tween = create_tween()
	tween.tween_property(self, "global_position:y", 300, fallDuration).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_interval(0)
	tween.tween_callback(finish_drop)

func finish_drop():
	queue_free()

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.type != source_type:
		if body.has_method("take_hit"):
			body.take_hit(own_body,damage,1.5, Vector2.DOWN)
