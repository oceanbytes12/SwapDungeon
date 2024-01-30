extends Node

var HeroIconPackedScenes = []

func _ready():
	HeroIconPackedScenes = Globals._LoadPackedScenesInPath("res://Michael WIP/HeroIcons/")


#Grabs an icon for that hero as a Sprite2D instance
func _GetIconInstanceOfType(HeroType):
	for HeroIcon in HeroIconPackedScenes:
		if(HeroIcon.resource_path.contains(HeroType)):
			#print("Found an icon for: ", HeroType)
			return HeroIcon.instantiate()
		else:
			#print("No find here: ", HeroType)
			pass
