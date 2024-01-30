extends Node2D

var selected_units = []
var is_Ctrl_pressed = false

@export var use_context_cursors = true

func _ready():
	Globals.AlexTester = self
	
	
func _physics_process(delta):
	if (use_context_cursors):
		# Display context sensitive text based on what mouse is hovering over
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
			#mouse_over_text = collider.mouse_over()
			var cursor_image = collider.mouse_over()
			Input.set_custom_mouse_cursor(cursor_image, 0, Vector2(50,50))
		else:
			Input.set_custom_mouse_cursor(null)
			

# Get all units within the bounds of the drawn rectangle
func get_units_in_area(area):
	var result = []
	for unit in get_children():
		if unit.is_in_group("unit"):
			if (unit.global_position.x > area[0].x) and (unit.global_position.x < area[1].x):
				if (unit.global_position.y > area[0].y) and (unit.global_position.y < area[1].y):
					result.append(unit)
	return result

func _on_camera_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	
	# Create visual area
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	selected_units = get_units_in_area(area)
	
	deselect_all_units()
	for u in selected_units: # Select the units in selection box
		u.set_selected(true)

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
