extends Node2D

var selected_units = []
var is_Ctrl_pressed = false

# Get all units within the bounds of the drawn rectangle
func get_units_in_area(area):
	var result = []
	for unit in $Units.get_children():
		if (unit.global_position.x > area[0].x) and (unit.global_position.x < area[1].x):
			if (unit.global_position.y > area[0].y) and (unit.global_position.y < area[1].y):
				result.append(unit)
	return result

func _on_camera_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	selected_units = get_units_in_area(area)
	
	# If player is pressing ctrl, don't deselect already selected units 
	if (!is_Ctrl_pressed):
		for unit in $Units.get_children():
			unit.set_selected(false)
	for u in selected_units: # Select the units in selection box
		u.set_selected(true)
