extends Node2D

# This script and Camera script work together to select units with mouse

var units = [] # All the units in player's party


# Camera object from UI node is passed to this
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	
	for u in units: # Deselect all units
		u.set_selected(false)
	for u in ut: # Select the units in selection box
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

