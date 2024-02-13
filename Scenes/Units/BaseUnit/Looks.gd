extends Node2D

var current_target : CharacterBody2D = null


func _process(_delta):
	if current_target:
		var target_vector = current_target.global_position - global_position
		if target_vector.x < 0:
			$CharacterArt.scale.x = -1
		elif target_vector.x > 0:
			$CharacterArt.scale.x = 1


func _on_state_machine_new_target(new_target):
	self.current_target = new_target


func _on_base_unit_moved():
	$MovementAnimations.play("Walk")


func _on_base_unit_stopped():
	$MovementAnimations.play("RESET")


