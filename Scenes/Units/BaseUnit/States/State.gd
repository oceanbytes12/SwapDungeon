extends Node
class_name State

signal ChangeState

func Enter(_own_body : CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary):
	pass


func Exit():
	pass


func Update(_delta: float, _own_body :CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary, walk_target):
	pass


func Physics_Update(_delta: float, _own_body :CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary, walk_target):
	pass


func find_closest_target(target_list, own_body):
	var new_target = null
	for target in target_list:
		var target_body = target_list.get(target)
		if new_target:
			var distance_to_target = own_body.global_position.distance_to(target_body.global_position)
			var distance_to_current = own_body.global_position.distance_to(new_target.global_position)
			if distance_to_target < distance_to_current:
				new_target = target_body
		else:
			new_target = target_body
	return new_target
