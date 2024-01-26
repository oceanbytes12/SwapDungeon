extends CharacterBody2D

@onready var target = global_position
@export var speed = 200

signal WalkCommand

var selected = false
var follow_cursor = false
var is_cursor_over = false
var is_Ctrl_pressed = false


func _physics_process(delta):
	move_and_slide()
	
func _ready():
	set_selected(selected)

func set_selected(value):
	selected = value
	#$.visible = value


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


func _on_mouse_entered():
	is_cursor_over = true


func _on_mouse_exited():
	is_cursor_over = false
