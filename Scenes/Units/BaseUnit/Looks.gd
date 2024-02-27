extends Node2D

var current_target : CharacterBody2D = null


func _process(_delta):
	if current_target:
		var target_vector = current_target.global_position - global_position
		if target_vector.x < 0:
			$CharacterArt.scale.x = -1
		elif target_vector.x > 0:
			$CharacterArt.scale.x = 1
		var vector_to_target = (current_target.global_position - global_position).normalized()
		
		if vector_to_target.y >= -0.25:
			$CharacterArt/Head/Back.visible = false
			$CharacterArt/Head/Front.visible = true
			$CharacterArt/Torso/Back.visible = false
			$CharacterArt/Torso/Front.visible = true
		else:
			$CharacterArt/Head/Back.visible = true
			$CharacterArt/Head/Front.visible = false
			$CharacterArt/Torso/Back.visible = true
			$CharacterArt/Torso/Front.visible = false

func _on_state_machine_new_target(new_target):
	self.current_target = new_target


func _on_base_unit_moved():
	$MovementAnimations.play("Walk")


func _on_base_unit_stopped():
	$MovementAnimations.play("RESET")


func _on_base_unit_selected(new_selection):
	if new_selection == "green":
		$Selection.play("FriendlySelected")
		$Selection.visible = true
	elif new_selection == "red":
		$Selection.play("EnemySelected")
		$Selection.visible = true
	else:
		$Selection.visible = false
