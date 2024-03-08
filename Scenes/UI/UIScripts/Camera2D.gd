extends Camera2D

class_name CameraController

# Draws a rectangle when player left clicks and drags mouse
signal area_selected
signal start_move_selection

@export var box : Panel

# Used for drawing select rectangle
var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false

var Shaker : CameraShaker
static var cam

func _ready():
	cam = self
	Shaker = CameraShaker.new(self)
	
	draw_area(false) # Prevents box from being drawn on load. Can also do this by setting default size to 0 in Inspector

# Handle mouse input
func _process(_delta):
	Shaker._tick(_delta)
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
		#Shaker.add_trauma(30)
		
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			isDragging = false
			draw_area(false)


func _input(event):
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()


# Draw player's selection rectangle
func draw_area(s = true):
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)


