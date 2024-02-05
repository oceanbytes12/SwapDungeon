extends State
class_name SlamReady

@export var anim : AnimationPlayer 
@export var own_body : CharacterBody2D

func Enter(_target):
	own_body.velocity = Vector2.ZERO
	anim.play("SlamReady")

func _ExitSlamReady():
	Transitioned.emit("SlamDown")
