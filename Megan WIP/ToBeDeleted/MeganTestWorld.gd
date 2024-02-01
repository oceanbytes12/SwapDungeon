extends Node2D

# This script and Camera script work together to select units with mouse click and drag
# Processes setting a player-chosen target for the units (not fully implemented yet)

@onready var cursor_text_box = get_node("CursorText")

var units = [] # All the units in player's party
var selected_units = []
var mouse_over_text = ""
var is_Ctrl_pressed = false

func _physics_process(delta):
	# Display context sensitive text based on what mouse is hovering over
	# get the Physics2DDirectSpaceState object
	var space = get_world_2d().direct_space_state
	# Get the mouse's position
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	query.position = get_global_mouse_position()
	var intersection = space.intersect_point(query,1)
	var collider = null

	if intersection:
		collider = intersection[0].collider
		
	if collider and collider.has_method("mouse_over"):
		mouse_over_text = collider.mouse_over()
	else:
		mouse_over_text = "Walk Here"
		
	cursor_text_box.text = mouse_over_text


# Select all player units inside the drawn selection rectangle
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	selected_units = get_units_in_area(area)
	
	# If player is pressing ctrl, don't deselect already selected units 
	if (!is_Ctrl_pressed):
		for u in units: # Deselect all units
			u.set_selected(false)
	for u in selected_units: # Select the units in selection box
		u.set_selected(true)


# Get all units within the bounds of the drawn rectangle
func get_units_in_area(area):
	var result = [] 
	for unit in units:
		if (unit.global_position.x > area[0].x) and (unit.global_position.x < area[1].x):
			if (unit.global_position.y > area[0].y) and (unit.global_position.y < area[1].y):
				result.append(unit)
	return result


func _on_party_units_ready(_units):
	units = _units


func _input(event):
	if event.is_action_pressed("Ctrl"):
		is_Ctrl_pressed = true
	if event.is_action_released("Ctrl"):
		is_Ctrl_pressed = false


func _on_enemy_unit_targeted(_target):
	# Set the "target" field/var of each currently selected unit (if any)
	for u in selected_units: # Select the units in selection box
		#u.set_target() # Change this to the correct function
		pass 
