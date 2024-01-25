extends StaticBody2D

class_name DropSpace

#@export_node_path(ColorRect) var colorRectNode
@export var colorRectNode: NinePatchRect
@export var heldNode: Draggable
@export var parent : Control

var duration = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	#_addToBody(heldNode)
	call_deferred("_moveToBody")
	
	
func _moveToBody():
	if(heldNode):
		heldNode.global_position = global_position

func _addToBody(addedNode):
	
	_set_targeted(false)
	
	addedNode.selectable = false
	if(heldNode):
		heldNode.selectable = false
	
	print("Sending: ", addedNode ," to ", global_position)
	#Move the nodes
	var tween = get_tree().create_tween()
	tween.tween_property(addedNode, "global_position", global_position, duration).set_ease(Tween.EASE_OUT)
	if(heldNode):
		print("Sending: ", heldNode ," to ", addedNode.initialPos)
		tween.parallel().tween_property(heldNode, "global_position", addedNode.initialPos, duration).set_ease(Tween.EASE_OUT)
	
	await tween.finished

	addedNode.selectable = true
	if(heldNode):
		heldNode.selectable = true
		
	#Finally this is our new boy after all this work.
	heldNode = addedNode
	
func _set_targeted(isTargeted):
	var newscale = 1.1 if isTargeted else 1
	colorRectNode.scale = Vector2(newscale,newscale)
