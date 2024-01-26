extends CharacterBody2D

signal WalkCommand

@export var distance_buffer = 15 # Stopping distance from movement target

@onready var movement_timer = $MovementTimer
@onready var box = get_node("UI/SelectedPanel")
@onready var target = global_position

var selected = false
var follow_cursor = false
var is_cursor_over = false
var is_Ctrl_pressed = false


@export var speed = 200


func _physics_process(delta):
	move_and_slide()

	## Right click mouse movement (if not using State Machine)
	#if follow_cursor == true:
		#if selected:
			#target = get_global_mouse_position()
			#$AnimationPlayer.play("Walk")
			#
	#velocity = global_position.direction_to(target) * speed
	#
	#if global_position.distance_to(target) > distance_buffer:
		#move_and_slide()
	#else:
		#$AnimationPlayer.stop()
		#movement_timer.stop()


func _ready():
	set_selected(selected)


func set_selected(value):
	selected = value
	box.visible = value


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
			movement_timer.start()
			WalkCommand.emit(get_global_mouse_position())
			
	if event.is_action_pressed("LeftClick"):
		# If player is pressing ctrl, don't deselect already selected units 
		if (!is_Ctrl_pressed):
			# Making sure we deselect if the user clicked elsewhere
			set_selected(false)
		
		# Select just this unit if the cursor is over it
		if (is_cursor_over):
			set_selected(true)


# Fixes issue with units getting stuck, jittering
func _on_movement_timer_timeout():
	target = global_position
	

func _on_mouse_entered():
	is_cursor_over = true


func _on_mouse_exited():
	is_cursor_over = false
