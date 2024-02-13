extends AnimationPlayer

var current_target : CharacterBody2D = null


func _process(_delta):
	pass
	## Quick fix to add back unit animations without affecting bosses
	#if can_be_stunned:
		#if velocity.length() < 1 and not is_dead:
			#$MovementAnimations.play("RESET")
		#elif velocity.length() < walkSpeed + 1 and not is_dead:
			#$MovementAnimations.play("Walk")
		#elif velocity.length() > walkSpeed and not is_dead:
			#$MovementAnimations.play("WalkFast")
	#if current_target != null:
		#var target_vector = current_target.global_position - $CharacterArt.global_position
		#if target_vector.x < 0:
			#$CharacterArt.scale.x = -1
		#elif target_vector.x > 0:
			#$CharacterArt.scale.x = 1


func _on_state_machine_new_target(new_target):
	self.current_target = new_target
