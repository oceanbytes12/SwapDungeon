extends State
class_name Cooldown

#signal Charge
#signal SmashGround
#signal Walk
#signal Melee
signal Cooldown

@export var own_body : CharacterBody2D
@export var cooldown_time := 4.0

var timeout_timer


func Enter(_target):
	print("Cooldown entered")
	timeout_timer = cooldown_time
	emit_signal("Cooldown")


func Update(delta: float, _target: CharacterBody2D):
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		print("Cooldown completed")
		if _target:
			Transitioned.emit("Follow")
		else:
			Transitioned.emit("Idle")
			

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2.ZERO
