extends CharacterBody2D

@export var teamColor : String
@export var controllable: bool

@onready var weapon = $Weapon
@onready var target = global_position

signal Hit
signal WalkCommand
signal AttackCommand
signal Died

var selected = false
var follow_cursor = false
var is_cursor_over = false
var is_Ctrl_pressed = false
var is_dead = false

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
		var pos = target.global_position
		if pos:
			weapon.look_at(pos)
	if velocity.x < 0:
		$Art/Body.flip_h = true
		$Art/Head.flip_h = true
	elif velocity.x > 0:
		$Art/Body.flip_h = false
		$Art/Head.flip_h = false

func _physics_process(_delta):
	move_and_slide()

func _input(event):
	if event.is_action_pressed("Ctrl"):
		is_Ctrl_pressed = true
	if event.is_action_released("Ctrl"):
		is_Ctrl_pressed = false
	
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false
		if (selected == true):
			WalkCommand.emit(get_global_mouse_position())
	if event.is_action_pressed("LeftClick"):
		# If player is pressing ctrl, don't deselect already selected units 
		if (!is_Ctrl_pressed):
			# Making sure we deselect if the user clicked elsewhere
			set_selected(false)
		# Select just this unit if the cursor is over it
		if (is_cursor_over):
			set_selected(true)

func take_hit(hit_position):
	$UI/HealthBar.value -= 25
	if $UI/HealthBar.value <= 0:
		is_dead = true
		$UI/HealthBar.visible = false
		Died.emit()
		queue_free()
	else:
		var direction = (global_position-hit_position).normalized()
		Hit.emit(direction)
		$AnimationPlayer.play("hitAnimation")
