extends State

@export var own_body : CharacterBody2D
@export var timeout := 3
@export var anim : AnimationPlayer 
var timeout_timer
var target_vector

func Enter(_target):
	print("Random move")
	timeout_timer = timeout
	anim.play("Walk")
	var xoff = randi_range(-1, 1) * 30
	var yoff = randi_range(-1, 1) * 30 
	target_vector = _target.global_position - own_body.global_position + Vector2(xoff, yoff) 


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		Transitioned.emit("SlamReady")

func Physics_Update(_delta: float, target: CharacterBody2D):
	if target:
		#target_vector = target.global_position - own_body.global_position
		var target_distance = target_vector.length()
		if 	target_distance < own_body.weaponRange:
			Transitioned.emit("SlamReady")
		else:
			own_body.velocity = target_vector.normalized() * own_body.runSpeed
