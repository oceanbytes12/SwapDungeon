extends CharacterBody2D

# MY CHANGES
@export var distance_buffer = 15

@onready var box = get_node("UI/SelectedPanel")
@onready var target = global_position

var selected = false
var follow_cursor = false
# END CHANGES

@export var speed = 200

var idle = true

func _physics_process(delta):
	# MY CHANGES
	# Right click mouse movement
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
			$AnimationPlayer.play("Walk")
			
	velocity = global_position.direction_to(target) * speed
	
	if global_position.distance_to(target) > distance_buffer:
		move_and_slide()
	else:
		$AnimationPlayer.stop()
	# END CHANGES
	
"""	# Keyboard movement
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var attack = Input.is_action_just_pressed("ui_accept")
	var direction = Vector2(direction_x, direction_y).normalized()
	
	if idle and direction != Vector2.ZERO:
		#$AnimationPlayer.play("Walk")
		idle = false
	elif direction == Vector2.ZERO and idle == false:
		idle = true
		#$AnimationPlayer.play("Idle")


	velocity = direction * speed
	move_and_slide()
"""
	
	
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
# END CHANGES
