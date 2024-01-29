extends CharacterBody2D

signal Targeted

#@export var distance_buffer = 15 # Stopping distance from movement target


var is_cursor_over = false


#@export var speed = 200


func _physics_process(delta):
	move_and_slide()


func _input(event):
	if event.is_action_pressed("LeftClick"):
		# Emit signal that this enemy unit has been selected as a target
		if (is_cursor_over):
			emit_signal("Targeted", self)


func _on_mouse_entered():
	is_cursor_over = true


func _on_mouse_exited():
	is_cursor_over = false
