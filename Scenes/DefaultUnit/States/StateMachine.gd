extends Node

@export var initial_state : State
@export var own_body : CharacterBody2D

var current_state : State
var states : Dictionary = {}
var targets : Dictionary = {}
var current_target : CharacterBody2D

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(on_state_change)
	if initial_state:
		initial_state.Enter(current_target)
		current_state = initial_state

func _process(delta):
	#if current_target :
		#targets.erase(current_target)
		#find_target()
	if current_state:
		current_state.Update(delta, current_target)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta, current_target)

func on_state_change(new_state_name):
	var new_state = states.get(new_state_name)
	current_state.Exit()
	new_state.Enter(current_target)
	current_state = new_state

func find_target():
	if targets.is_empty():
		current_target = null
	else:
		# this is trash we should add a way to check for closest
		for target in targets:
			current_target = targets.get(target)

func _on_unit_sm_hit(direction):
	if current_state.name != "Dead":
		var new_state = states.get("Stun")
		current_state.Exit()
		new_state.hit_direction = direction
		new_state.Enter(current_target)
		current_state = new_state


func _on_base_unit_walk_command(click_position):
	if current_state.name != "Dead":
		on_state_change("Walk")
		current_state.target_position = click_position


func _on_base_unit_died():
	on_state_change("Dead")


func _on_sight_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("unit") and body.teamColor != own_body.teamColor:
		if targets.is_empty():
			current_target = body
		targets[body.name] = body


func _on_sight_range_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	targets.erase(body.name) # Alex needs to fix this trash
	find_target()


func _on_base_unit_attack_command(_target):
	#may need to clear other target vars?
	current_target = _target
	#on_state_change("Attack")
	on_state_change("Follow")
