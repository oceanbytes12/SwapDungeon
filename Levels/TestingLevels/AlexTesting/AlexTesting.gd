extends Node2D

var selected_units = []
var targeted_unit = null
var is_Ctrl_pressed = false
@export var use_context_cursors = true
#@export var mouse_pointer: Resource

@onready var cameraScript = $Camera

#func _ready():
	#Globals.AlexTester = self		

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
	if(is_instance_valid(collider)):
		var clicked_unit = collider.get_parent() #Collider is Nil?
		if clicked_unit.is_in_group("unit") and collider.name == "ClickBox":
			return clicked_unit
	return null

func _input(event):
	if event.is_action_pressed("Ctrl"):
		is_Ctrl_pressed = true
	if event.is_action_released("Ctrl"):
		is_Ctrl_pressed = false
	if event.is_action_pressed("RightClick"):
		if targeted_unit:
			targeted_unit.set_targeted(false)

		var clicked_unit = check_object_under_mouse()
		# if Unit isn't controllable we know it's a enemy unit
		if clicked_unit and not clicked_unit.controllable and not clicked_unit.is_dead:
			clicked_unit.set_targeted(true)
			targeted_unit = clicked_unit
			for unit in selected_units:
				if unit.controllable:
					unit.set_target(clicked_unit)
			var effect = attack_effect.instantiate()
			effect.global_position = get_global_mouse_position()
			add_child(effect)
		else:
			for unit in selected_units:
				if clicked_unit and clicked_unit.controllable and unit.support_unit:
					unit.set_target(clicked_unit)
				elif unit.controllable:
					unit.set_walk()
			var effect = click_effect.instantiate()
			effect.global_position = get_global_mouse_position()
			add_child(effect)
	if event.is_action_pressed("LeftClick"):
		deselect_all_units()
		var clicked_unit = check_object_under_mouse()
		# if Unit is controllable we know it's a player unit
		if clicked_unit and clicked_unit.controllable:
			clicked_unit.set_selected(true)
			selected_units.append(clicked_unit)
	if event.is_action_pressed("KillEnemies"):
		_kill_all_enemies()
	if event.is_action_pressed("KillFriends"):
		_kill_all_players()

func deselect_all_units():
	# If player is pressing ctrl, don't deselect already selected units
	if (!is_Ctrl_pressed):
		selected_units = []
		for unit in get_children():
			if unit.is_in_group("unit"):
				unit.set_selected(false)
		if targeted_unit:
			targeted_unit.set_targeted(false)
			targeted_unit = null
	
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

func _Toggle(isOn):
	cameraScript.set_process(isOn)
	cameraScript.set_physics_process(isOn)
	cameraScript.set_process_input(isOn)
	
	set_process(isOn)
	set_physics_process(isOn)
	set_process_input(isOn)
