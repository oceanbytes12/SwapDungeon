extends AnimatedSprite2D

#signal ChargeImpact #old, will be removed
# For syncing charge animation with the charge state's logic
signal StartCharge
signal EndCharge
signal ChargeAnimComplete

signal StartAOE
signal AOEAnimComplete

var chargeStartFrame = 3 # Indicate when boss should rush/stop
var chargeEndFrame = 5
var chargeAnimEndFrame = 7 # The last frame of the charge animation

var aoeStartFrame = 2 # This is the frame when the AOE attack effect should instantiate
var aoeAnimEndFrame = 4

#ISSUE: These signals are getting called multiple times per frame.
# Desired to only be called once
# Hotfix for this problem:
var aoeStart_HasBeenNotified = false 


func _process(delta):
	# Start charge movement, Turn on ChargeCollision collider
	if animation == "Charge":
		if frame == chargeStartFrame:
			StartCharge.emit()
		elif frame == chargeEndFrame:
			EndCharge.emit()
		elif frame == chargeAnimEndFrame:
			ChargeAnimComplete.emit()

	# Instantiate AOE effect
	if animation == "SmashGround":
		if frame == aoeStartFrame and aoeStart_HasBeenNotified == false:
			StartAOE.emit()
			aoeStart_HasBeenNotified = true
		elif frame == aoeAnimEndFrame:
			AOEAnimComplete.emit()
			aoeStart_HasBeenNotified = false # Reset for next time

func _on_idle_idle():
	play("Idle")


func _on_follow_charge():
	play("Charge")


func _on_follow_melee():
	pass
	#play("Melee")


func _on_follow_smash_ground():
	play("SmashGround")


func _on_follow_walk():
	play("Walk")


func _on_cooldown_cooldown():
	play("Idle")
