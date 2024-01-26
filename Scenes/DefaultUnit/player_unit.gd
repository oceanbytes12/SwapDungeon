extends CharacterBody2D

@onready var target = global_position
@export var speed = 200

signal WalkCommand

var selected = false
var follow_cursor = false


func _physics_process(delta):
	move_and_slide()
	
func _ready():
	set_selected(selected)

func set_selected(value):
	selected = value
	$.visible = value


func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true

	if event.is_action_released("RightClick"):
		follow_cursor = false
		if (selected == true):
			WalkCommand.emit(get_global_mouse_position())
			
	if event.is_action_pressed("LeftClick"):
		set_selected(false)
