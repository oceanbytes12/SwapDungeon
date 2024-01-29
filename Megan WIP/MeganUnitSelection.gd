extends Node2D

# This script and Camera script work together to select units with mouse click and drag
# Processes clicking on units 

@onready var cursor_text_box = get_node("CursorText")
#@export var cursor_image_generic = load("res://Megan WIP/Cursor_Star.png")
#@export var cursor_image_attack = load("res://Megan WIP/Cursor_Sword.png")
@export var use_context_cursors = true

var units = [] # All the units in player's party
var selected_units = []
#var mouse_over_text = ""
var is_Ctrl_pressed = false


func _ready():
	units = get_tree().get_nodes_in_group("unit")


func _on_camera_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	selected_units = get_units_in_area(area)
	
	deselect_all_units()
	for u in selected_units: # Select the units in selection box
		u.set_selected(true)



func _physics_process(delta):
	
	if (use_context_cursors):
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
			#mouse_over_text = collider.mouse_over()
			var cursor_image = collider.mouse_over()
			Input.set_custom_mouse_cursor(cursor_image, 0, Vector2(50,50))
		else:
			#mouse_over_text = "Walk Here"
			Input.set_custom_mouse_cursor(null)
			
		#cursor_text_box.text = mouse_over_text


# Select all player units inside the drawn selection rectangle
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	
	deselect_all_units()
	selected_units = get_units_in_area(area)
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


func _input(event):
	if event.is_action_pressed("Ctrl"):
		is_Ctrl_pressed = true
	if event.is_action_released("Ctrl"):
		is_Ctrl_pressed = false
		
	if event.is_action_pressed("LeftClick"):
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
			if (collider.name == "MouseOverShape"):
				var clicked_unit =  collider.get_parent()
				# if the parent is controllable, we know it's a player unit
				if clicked_unit.controllable:
					deselect_all_units()
					# Select this unit, add to array
					clicked_unit.set_selected(true)
					selected_units.append(clicked_unit)
				# Otherwise, we know it's an enemy unit
				else:
					# Set the clicked enemy unit as the target for all selected units
					set_player_unit_target(clicked_unit)
			else: # Making sure we deselect if the user clicked elsewhere
				deselect_all_units()
		else: 
			deselect_all_units()


func deselect_all_units():
	# If player is pressing ctrl, don't deselect already selected units
	if (!is_Ctrl_pressed):
		selected_units = []
		for u in units:
			u.set_selected(false)


func set_player_unit_target(_target):
	for u in selected_units: # Set target for all currently selected units
		u.set_target(_target) 

