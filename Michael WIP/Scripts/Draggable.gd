extends Node2D

class_name Draggable

#variables for Drag & Drop
var selectable = true
var selected = false
var bodyRef : DropSpace
var offset: Vector2
var initialPos: Vector2 #stores initial position of object
var duration = 0.1

func _process(delta):
	#print("Process!")
	#code for Drag & Drop
	if selected:
		#print("selected")
		#if event.is_action_pressed("LeftClick"):
		if Input.is_action_just_pressed("LeftClick"):
			print("Left Click pressed!")
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Globals.isDragging = true
			
		if Input.is_action_pressed("LeftClick"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("LeftClick"):
			Globals.isDragging = false 
			if bodyRef:
				print("Adding to bodyRef.")
				bodyRef._addToBody(self)
			else:
				print("Releasing Draggable but we have no target body, returning to origin.")
				_return_to_origin()
	
	if selected:
		scale = Vector2(1.3, 1.3)
	else: 
		scale = Vector2(1,1)

func _return_to_origin():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", initialPos, duration).set_ease(Tween.EASE_OUT)

#Select Area connect Signals
func _on_select_area_mouse_entered():
	if not Globals.isDragging && selectable:
		selected = true

func _on_select_area_mouse_exited():
	if not Globals.isDragging:
		selected = false

func _on_select_area_body_entered(body):
	if(is_instance_of(body, DropSpace) and Globals.isDragging):
		bodyRef = body
		bodyRef._set_targeted(true)
		print("Entered DropSpace while dragged")

func _on_select_area_body_exited(body):
	if(is_instance_of(body, DropSpace) and Globals.isDragging):
		if(body == bodyRef):
			bodyRef._set_targeted(false)
			bodyRef = null
		print("Exited DropSpace while dragged")
