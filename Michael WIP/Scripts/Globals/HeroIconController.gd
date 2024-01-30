extends Node

var HeroIconPackedScenes = []
var Path : String = "res://Michael WIP/HeroIcons/"
func _ready():
	HeroIconPackedScenes = Globals._LoadPackedScenesInPath(Path)


#Grabs an icon for that hero as a Sprite2D instance
func _GetIconInstanceOfType(HeroType):
	for HeroIcon in HeroIconPackedScenes:
		if(HeroIcon.resource_path.contains(HeroType)):
			#print("Found an icon for: ", HeroType)
			return HeroIcon.instantiate()
		else:
			#print("No find here: ", HeroType)
			pass
