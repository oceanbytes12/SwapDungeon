extends Node2D

# Parent of the player's Party of units. 
# Manages communications with world camera, swapping units (not implemented yet)


# Signal used to pass unit info to World/Camera
signal units_ready

# Character/unit slots
@onready var character1 = get_node("Character1")
@onready var character2 = get_node("Character2")
@onready var character3 = get_node("Character3")
@onready var character4 = get_node("Character4")

var units = []


func _ready():
	init_units()


# Build list of units in party
func init_units():
	# Each character slot should only have one child node. All other cases are ignored.
	if (character1.get_child_count() == 1):
		units.append(character1.get_child(0))
	if (character2.get_child_count() == 1):
		units.append(character2.get_child(0))
	if (character3.get_child_count() == 1):
		units.append(character3.get_child(0))
	if (character4.get_child_count() == 1):
		units.append(character4.get_child(0))
	
	# Pass units to world/camera
	emit_signal("units_ready", units)


