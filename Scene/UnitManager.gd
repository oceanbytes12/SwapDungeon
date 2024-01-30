extends Node

class_name UnitManager

var levelFolder = "res://Scenes/Units/Players/"
var levelIndex = 0
var units = []

func _ready():
	units = Globals._LoadPackedScenesInPath(levelFolder)

#Grabs an icon for that hero as a Sprite2D instance
func _GetUnitInstanceOfType(HeroType):
	for unit in units:
		if(unit.resource_path.contains(HeroType)):
			#print("Found an icon for: ", HeroType)
			return unit.instantiate()
		else:
			#print("No find here: ", HeroType)
			pass
