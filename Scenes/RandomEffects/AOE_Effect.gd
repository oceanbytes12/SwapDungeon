extends Node2D

@export var color : Color = Color.RED

var location = Vector2(0, 0)
var radius = 0.0
var final_radius = 30.0
var damage = 10
var speed = 50

var initialized = false
var circleCollider
var playerUnitsInRange = []


#func _ready():
	## Test init here
	#initialize(final_radius, damage, speed)
	
func initialize(_radius, _damage, _speed):
	print("initialize called on aoe_effect")
	#location = position
	final_radius = _radius
	damage = _damage
	speed = _speed
	initialized = true
	
	# Resize the CollisionShape to match the final radius
	$Area2D/CollisionShape2D.shape.radius = final_radius


func _draw():
	#draw_circle(position, radius, color)
	draw_circle(global_position, radius, color)
	#draw_circle(location, radius, color)


func _process(delta):
	# Draw an expanding circle from 0 in delta increments until we reach final radius
	if (initialized):
		if (radius < final_radius):
			radius = radius + (delta * speed)
			queue_redraw()
		else:
			# Register damage on all player units inside the circle before queue_free
			apply_damage()


func apply_damage():
	#Check for player unit in radius, apply hits, then queue_free()
	for u in playerUnitsInRange:
		u.take_hit(position, damage)
	queue_free()


func _on_area_2d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("unit") and body.controllable:
		#print("player body added")
		playerUnitsInRange.append(body)


func _on_area_2d_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if body in playerUnitsInRange:
		#print("player body removed")
		var arrayPos = playerUnitsInRange.find(body)
		playerUnitsInRange.remove_at(arrayPos)
