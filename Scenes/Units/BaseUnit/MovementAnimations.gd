extends AnimationPlayer


#func _process(_delta):
	## Quick fix to add back unit animations without affecting bosses
	#if can_be_stunned:
		#if velocity.length() < 1 and not is_dead:
			#$MovementAnimations.play("RESET")
		#elif velocity.length() < walkSpeed + 1 and not is_dead:
			#$MovementAnimations.play("Walk")
		#elif velocity.length() > walkSpeed and not is_dead:
			#$MovementAnimations.play("WalkFast")
	#if $SM.current_target:
		#var target_vector = $SM.current_target.global_position - global_position
		#if target_vector.x < 0:
			#$Art/Body.flip_h = true
			#$Art/Head.flip_h = true
		#elif target_vector.x > 0:
			#$Art/Body.flip_h = false
			#$Art/Head.flip_h = false
