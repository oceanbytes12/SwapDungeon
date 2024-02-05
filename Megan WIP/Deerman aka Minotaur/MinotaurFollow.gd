extends State
class_name MinotaurFollow

@export var own_body : CharacterBody2D
@export var timeout := 2
@export var anim : AnimationPlayer 
var timeout_timer


func Enter(_target):
	timeout_timer = timeout
	anim.play("Walk")


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("Idle")

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		var target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < own_body.weaponRange:
			Transitioned.emit("SlamReady")
		else:
			own_body.velocity = target_vector.normalized() * own_body.runSpeed
