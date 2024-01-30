extends Node2D

var selected_units = []
var is_Ctrl_pressed = false
@export var use_context_cursors = true
#@export var mouse_pointer: Resource
@export var mouse_pointer = load("res://Art/MousePointer1.png")

func _ready():
	Globals.AlexTester = self
	
func _physics_process(_delta):
	if (use_context_cursors):
		var collider = check_collider_under_mouse()
		if collider and collider.has_method("mouse_over"):
			#mouse_over_text = collider.mouse_over()
			Input.set_custom_mouse_cursor(mouse_pointer, 0, Vector2(16,16))
		else:
			Input.set_custom_mouse_cursor(mouse_pointer, 0, Vector2(16,16))
			

# Get all units within the bounds of the drawn rectangle
func get_units_in_area(area):
	var result = []
	for unit in get_children():
		if unit.is_in_group("unit") and unit.controllable:
			if (unit.global_position.x > area[0].x) and (unit.global_position.x < area[1].x):
				if (unit.global_position.y > area[0].y) and (unit.global_position.y < area[1].y):
					result.append(unit)
	return result

func _on_camera_area_selected(object):
	# Create visual area
	var area = []
	var start = object.start
	var end = object.end
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))

	# Select units in area
	deselect_all_units()
	selected_units = get_units_in_area(area)
	for unit in selected_units: # Select the units in selection box
		unit.set_selected(true)

func check_collider_under_mouse():
	# Get the mouse's position
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.position = get_global_mouse_position()
	# Check for collider
	var intersection = space.intersect_point(query,1)
	if intersection:
		return intersection[0].collider
	else:
		return null

func check_object_under_mouse():
	var collider = check_collider_under_mouse()
	var clicked_unit = collider.get_parent()
	if clicked_unit.is_in_group("unit") and collider.name == "ClickBox":
		return clicked_unit
	return null

func _input(event):
	if event.is_action_pressed("Ctrl"):
		is_Ctrl_pressed = true
	if event.is_action_released("Ctrl"):
		is_Ctrl_pressed = false
	
	if event.is_action_pressed("RightClick"):
		var clicked_unit = check_object_under_mouse()
		# if Unit isn't controllable we know it's a enemy unit
		if clicked_unit and not clicked_unit.controllable:
			for unit in selected_units:
				if unit.controllable:
					unit.set_target(clicked_unit)
		else:
			for unit in selected_units:
				if unit.controllable:
					unit.set_walk()
		
	if event.is_action_pressed("LeftClick"):
		deselect_all_units()
		var clicked_unit = check_object_under_mouse()
		# if Unit is controllable we know it's a player unit
		if clicked_unit and clicked_unit.controllable:
			clicked_unit.set_selected(true)
			selected_units.append(clicked_unit)
	

func deselect_all_units():
	# If player is pressing ctrl, don't deselect already selected units
	if (!is_Ctrl_pressed):
		selected_units = []
		for unit in get_children():
			if unit.is_in_group("unit"):
				unit.set_selected(false)
	
func _kill_all_enemies():
	for unit in get_children():
		if unit.is_in_group("unit") and !unit.controllable:
			unit.Die()

func _kill_all_players():
	for unit in get_children():
		if unit.is_in_group("unit") and unit.controllable:
			unit.Die()

func EnemiesAreDead():
	for unit in get_children():
		if unit.is_in_group("unit"):
			if (!unit.is_dead and !unit.controllable):
				return false
	return true

func PlayersAreDead():
	for unit in get_children():
		if unit.is_in_group("unit"):
			if (!unit.is_dead  and unit.controllable):
				return false
	return true
