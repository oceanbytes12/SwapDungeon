extends CharacterBody2D

@export var teamColor : String
@export var controllable: bool

@onready var weapon = $Weapon
@onready var target = global_position

signal Hit
signal WalkCommand
signal AttackCommand

var selected = false
var follow_cursor = false

func set_selected(value):
	if controllable:
		selected = value
		$Art/Selection.visible = value
	else:
		$Art/Selection.visible = false

func _ready():
	set_selected(selected)
	weapon.teamColor = teamColor
	if teamColor == "blue":
		$Art/BlueHat.visible = true
		$Art/RedHat.visible = false
	elif teamColor == "red":
		$Art/BlueHat.visible = false
		$Art/RedHat.visible = true
	

func _process(_delta):
	target = $SM.current_target
	if target:
		weapon.look_at(target.global_position)
	if velocity.x < 0:
		$Art/Body.flip_h = true
		$Art/Head.flip_h = true
	elif velocity.x > 0:
		$Art/Body.flip_h = false
		$Art/Head.flip_h = false

func _physics_process(_delta):
	move_and_slide()

func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false
		if (selected == true):
			WalkCommand.emit(get_global_mouse_position())
	if event.is_action_pressed("LeftClick"):
		set_selected(false)

func take_hit(hit_position):
	var direction = (global_position-hit_position).normalized()
	Hit.emit(direction)
	$AnimationPlayer.play("hitAnimation")

