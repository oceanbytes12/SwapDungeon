extends Area2D

var source_team_color
@export var speed :float
@export var lifetime:float = 10
@export var grow_time:float = 0.25
@export var accelerate_wait_time:float = 1
@export var accel_speed : float = 1
@export var turn_speed = 3
@export var random_scale_factor = 0.2


var target
var damage = 5
var current_speed
var accelerating

func _ready():
	
	if(accel_speed > 0):
		current_speed = 0
	else:
		current_speed = speed
		
	$AnimatedSprite2D.play("Spell")
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		rotate(-PI/5)
	else:
		rotate(PI/5)
	
	if(accel_speed > 0):
		_grow()

func _grow():
	scale = Vector2.ZERO
	
	var tween = create_tween()
	random_scale_factor 	= randf_range(-random_scale_factor , random_scale_factor)
	var newScale = Vector2(1+random_scale_factor, 1+random_scale_factor)
	tween.tween_property(self, "scale", newScale, grow_time)
	
	tween.tween_callback(_start_accel)
	
func _start_accel():
	await get_tree().create_timer(accelerate_wait_time).timeout
	if(accel_speed > 0):
		accelerating = true
		
func _shrink():
	var tween = create_tween() 
	tween.tween_property(self, "scale", Vector2(0,0), 0.25)
	tween.tween_callback(_die)
		
func _process(delta):
	if(lifetime > 0):
		lifetime -= delta
	elif(lifetime < 0):
		lifetime = 0
		_shrink()

func _die():
	print("Dieing")
	queue_free()

func _rotate_to_target(delta):
	var goal_rotation = position.angle_to_point(target.position)
	var diff_rotation = angle_to_angle(rotation, goal_rotation)
	if diff_rotation > 0:
		rotate(turn_speed*delta)
	else:
		rotate(-turn_speed*delta)

func _physics_process(delta):
	
	if(accelerating):
		if(current_speed < speed):
			current_speed = current_speed + accel_speed
	else:
		_rotate_to_target(delta)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x > 0:
		$AnimatedSprite2D.flip_v = false
	else:
		$AnimatedSprite2D.flip_v = true
		
	position += direction * current_speed * delta

func _on_body_entered(body):
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.teamColor != source_team_color:
		if body.has_method("take_hit"):
			body.take_hit(global_position, damage)
			queue_free()

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
