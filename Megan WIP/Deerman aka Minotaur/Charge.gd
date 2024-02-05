extends State
class_name Charge


@export var own_body : CharacterBody2D
@export var anim : AnimationPlayer 
@export var Spr : Sprite2D

func Enter(_target):
	anim.play("ReadyCharge")
	if(_target.position.x > own_body.position.x):
		Spr.flip_h = true
	else:
		Spr.flip_h = false
		
func Update(delta: float, _target: CharacterBody2D):
	pass

func Physics_Update(_delta: float, _target: CharacterBody2D):
	pass

func _StartCharge():
	print("Charging Forward!")
	Transitioned.emit("ChargeForward")
