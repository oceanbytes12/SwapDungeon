extends Node
class_name State

signal ChangeState

func Enter(_own_body : CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary):
	pass


func Exit():
	pass


func Update(_delta: float, _own_body :CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary, _walk_target):
	pass


func Physics_Update(_delta: float, _own_body :CharacterBody2D, _current_target: CharacterBody2D, _target_list : Dictionary, _walk_target):
	pass

func clean_dict(dirty_dirty_dict: Dictionary) -> Dictionary:
	var cleaned_dict = {}
	for key in dirty_dirty_dict:
		var value = dirty_dirty_dict[key]
		if is_instance_valid(value):
			cleaned_dict[key] = value
			
	return cleaned_dict
	
func find_closest_target(target_list, own_body):
	var new_target = null
	
	#Cleanup any dead guys. As a treat.
	target_list = clean_dict(target_list)
	
	for target in target_list:
		var target_body = target_list.get(target)
		if is_instance_valid(new_target):
			var distance_to_target = own_body.global_position.distance_to(target_body.global_position)
			var distance_to_current = own_body.global_position.distance_to(new_target.global_position)
			if distance_to_target < distance_to_current:
				new_target = target_body
		else:
			new_target = target_body
	return new_target
