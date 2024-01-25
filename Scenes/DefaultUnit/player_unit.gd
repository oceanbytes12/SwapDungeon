extends CharacterBody2D

signal WalkCommand

# MY CHANGES
@export var distance_buffer = 15 # Stopping distance from movement target

@onready var movement_timer = $MovementTimer
@onready var box = get_node("UI/SelectedPanel")
@onready var target = global_position

var selected = false
var follow_cursor = false
# END CHANGES

@export var speed = 200

var idle = true

func _physics_process(delta):
	move_and_slide()
	## MY CHANGES
	## Right click mouse movement
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
	## END CHANGES
	
	
# MY CHANGES
func _ready():
	set_selected(selected)


func set_selected(value):
	selected = value
	box.visible = value


func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true

	if event.is_action_released("RightClick"):
		follow_cursor = false
		if (selected == true):
			movement_timer.start()
			WalkCommand.emit(get_global_mouse_position())
			
	if event.is_action_pressed("LeftClick"):
		set_selected(false)


# Fixes issue with units getting stuck, jittering
func _on_movement_timer_timeout():
	target = global_position
	
# END CHANGES
