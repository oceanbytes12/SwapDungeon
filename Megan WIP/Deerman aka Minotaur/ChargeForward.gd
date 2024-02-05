extends State
class_name ChargeReady


@export var own_body : CharacterBody2D
@export var stunTime := 0.5
@export var anim : AnimationPlayer 
@export var ChargeCol : CollisionShape2D
@export var BodyCol : CollisionShape2D
@export var Spr : Sprite2D
var dir :float = 0
var spd:float = 300

func Enter(_target):
	if(!is_instance_valid(_target)):
		print("No target?")
		Transitioned.emit("Idle")
		return
		
	
	BodyCol.disabled = true
	ChargeCol.disabled = false
	print("Charging!")
	anim.play("Charge")
	if(_target.position.x > own_body.position.x):
		dir = 1
		ChargeCol.rotation = 180
	else:
		dir = -1
		ChargeCol.rotation = 0

	
func Update(delta: float, _target: CharacterBody2D):
	if(own_body.velocity.x > 0):
		Spr.flip_h = true
	else:
		Spr.flip_h = false
		
	if(own_body.position.x > 160 or own_body.position.x < -200):
		ChargeCol.set_deferred("disabled",true)
		BodyCol.set_deferred("disabled", false)
		Transitioned.emit("Idle")
		
func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2.RIGHT * dir * spd



func _on_charge_collision_area_entered(area):
	#print("AreaEntered: ", area.name)
	pass


func _on_charge_collision_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#print("shapeEntered1: ", area.name)
	pass
