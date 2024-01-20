extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}
var targets : Dictionary = {}
var current_target : CharacterBody2D

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta, current_target)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta, current_target)


func on_child_transition(new_state_name):
	var new_state = states.get(new_state_name)
	current_state.Exit()
	new_state.Enter()
	current_state = new_state

func _on_sight_range_body_entered(body):
	if body.is_in_group("Friendly"):
		if targets.is_empty():
			current_target = body
		targets[body.name] = body


func _on_sight_range_body_exited(body):
	if body.is_in_group("Friendly"):
		targets.erase(body.name)
		if targets.is_empty():
			current_target = null
		else:
			# this is trash we should add a way to check for closest
			for target in targets:
				current_target = targets.get(target)
