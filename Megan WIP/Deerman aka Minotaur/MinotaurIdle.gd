extends State
class_name MinotaurIdle

signal Idle
@export var anim : AnimationPlayer 
@export var own_body: CharacterBody2D

var move_direction : Vector2
var wander_time : float
var idle_Time = 3
@onready var current_Idle_Time = idle_Time

func Enter(_target):
	anim.play("Idle")
	emit_signal("Idle")
	current_Idle_Time = idle_Time

func Update(delta: float, target: CharacterBody2D):
	current_Idle_Time = current_Idle_Time - delta
	if target && current_Idle_Time <= 0:
		Transitioned.emit("Follow")

func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2.ZERO
