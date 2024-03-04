extends Node

class_name StateMachine

@export var initial_state : State
@export var own_body : CharacterBody2D

signal newTarget
signal newWalk

var current_state : State = initial_state
var states : Dictionary = {}
var target_list : Dictionary = {}
var current_target : CharacterBody2D = null
var walk_target : Vector2 = Vector2.ZERO 
var newname
func _ready():
	newname = own_body.name
	# Connect to all the states
	# All states have a ChangeState signal inherited from State.gd
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.ChangeState.connect(on_state_change)
	initial_state.Enter(own_body, current_target, target_list)
	current_state = initial_state

func _process(delta):
	if(is_instance_valid(own_body)):
		current_state.Update(delta, own_body, current_target, target_list, walk_target)

func _physics_process(delta):
	if(is_instance_valid(own_body)):
		current_state.Physics_Update(delta, own_body, current_target, target_list, walk_target)
		
func on_state_change(new_state_name, new_target, new_walk_target):
	self.walk_target = new_walk_target
	if walk_target != Vector2.ZERO:
		newWalk.emit(walk_target)
	else:
		newWalk.emit(Vector2.ZERO)
	current_target = new_target
	newTarget.emit(current_target)
	var new_state = states.get(new_state_name)
	current_state.Exit()
	new_state.Enter(own_body, current_target, target_list)
	current_state = new_state

func _on_sight_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("unit") and body.type != own_body.type and body.name not in target_list:
		target_list[body.name] = body
		body.Died.connect(_on_target_died)

func _on_target_died(body):
	if body.name in target_list:
		target_list.erase(body.name)
	if current_target == body:
		current_target = null
		newTarget.emit(current_target)

func unit_hit(source_body, damage, knockback_amount, knockback_direction, freeze):
	if !is_instance_valid(own_body):
		return
		
	if !is_instance_valid(source_body):
		return
		
	if source_body.name not in target_list:
		target_list[source_body.name] = source_body
		source_body.Died.connect(_on_target_died)
		
	var new_state = states.get("Stun")
	new_state.handle_hit(own_body, damage, knockback_amount, 
	knockback_direction, freeze, current_target, walk_target)
	#new_state.Enter(own_body, current_target, target_list)
	#current_state = new_state
	
func walk_command(walk_position):
	newWalk.emit(walk_position)
	current_target = null
	walk_target = walk_position

func attack_command(new_target):
	current_target = new_target
	walk_target = Vector2.ZERO
