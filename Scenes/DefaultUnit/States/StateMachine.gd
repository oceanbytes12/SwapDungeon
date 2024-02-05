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
	#if own_body.teamColor == "red":
		#print(current_state)
	if current_state:
		current_state.Update(delta, current_target)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta, current_target)

func on_state_change(new_state_name):
	var new_state = states.get(new_state_name)
	current_state.Exit()
	new_state.Enter(current_target)
	find_target()
	current_state = new_state

func find_target():
	current_target = null
	# Finds the closest enemy
	for target in targets:
		var target_body = targets.get(target)
		if current_target:
			var distance_to_target = own_body.global_position.distance_to(target_body.global_position)
			var distance_to_current = own_body.global_position.distance_to(current_target.global_position)
			if distance_to_target < distance_to_current:
				current_target = target_body
		else:
			current_target = target_body


func _on_unit_sm_hit(direction, damage, hitstun):
	if current_state.name != "Dead" and get_parent().can_be_stunned:
		if damage >= 0:
			var new_state = states.get("Stun")
			current_state.Exit()
			new_state.hit_direction = direction
			new_state.stunKnockback = hitstun
			
			if(new_state.has_method("UpdateDamage")):
				new_state.UpdateDamage(damage)
				
			new_state.Enter(current_target)
			current_state = new_state


func _on_base_unit_walk_command(click_position):
	if current_state.name != "Dead":
		on_state_change("Walk")
		current_target = null
		current_state.target_position = click_position


func _on_base_unit_died():
	on_state_change("Dead")


func _on_sight_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("unit") and body.teamColor != own_body.teamColor:
		if targets.is_empty():
			current_target = body
		targets[body.name] = body


func _on_sight_range_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("unit") and body.is_dead:
		targets.erase(body.name) # Alex needs to fix this trash
		find_target()
	elif body.is_in_group("unit") and not own_body.controllable:
		targets.erase(body.name) # Alex needs to fix this trash
		find_target()


func _on_base_unit_attack_command(target):
	if(!is_instance_valid(target)):
		#Wierd bug that occurs even in lonely scenes...
		#print("Invalid Target for: ", own_body.name)
		return
	
	if targets.get(target.name):
		current_target = target
	else:
		targets[target.name] = target
		current_target = target
	#on_state_change("Follow")

