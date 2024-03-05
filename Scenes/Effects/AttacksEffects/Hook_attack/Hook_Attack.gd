extends Area2D
var own_body
var source_team_color
var speed = 200
var target
var damage = 50
var source_type
@export var tip : Node2D
@export var links : Node2D
@export var LinksSprite : Sprite2D
@export var Collision : CollisionShape2D

var startPosition
var tipPosition
var contracting : bool = false
var endPosition

func set_transform_params(global_position, rotation):
	self.rotation = rotation
	self.global_position = global_position

func set_params(new_own_body, new_damage, new_knockback_amount, target=null):
	self.target = target
	self.own_body = new_own_body
	self.damage = new_damage
	self.source_type = self.own_body.type
	self.startPosition = self.global_position
	self.endPosition = target.global_position
	self.tipPosition = self.global_position
	look_at(endPosition)

func _physics_process(delta):
	var move_vec = Vector2(1, 0).rotated(rotation)
	#var dir = global_transform.basis_xform(Vector2.RIGHT)
	if(contracting):
		tip.global_position -= move_vec	* speed * delta
		
		if(tip.global_position.distance_to(global_position) < 10):
			queue_free()
	else:
		tip.global_position += move_vec	* speed * delta
		
		if(tip.global_position.distance_to(endPosition) < 10):
			contracting = true
			speed = speed * 3
			
	tipPosition = tip.global_position
	Collision.global_position = tip.global_position
	
func _process(delta):
	var tip_loc = to_local(tip.global_position)
	LinksSprite.region_rect.size.y = tip_loc.length()
	links.position = tip_loc + Vector2.LEFT * 9

func _on_body_entered(body):
	print("Hit: " + body.name)
	# Check if hitting self or friend
	if body.is_in_group("unit") and body.type != source_type:
		if body.has_method("take_hit"):
			body.take_hit(own_body,damage,5,startPosition-endPosition)
