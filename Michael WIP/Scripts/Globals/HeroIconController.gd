extends Node

#@onready var HeroIconPackedScenes = Globals._LoadPackedScenesInPath(Path)
var Path : String = "res://Michael WIP/HeroIcons/"

@export var HeroIconNames : Array[String]
@export var HeroIconPackedScenesArray:Array[PackedScene]

var HeroIconPackedScenes:Dictionary

func _ready():
	Globals.Icons = self
	for Index in range(HeroIconNames.size()):
		HeroIconPackedScenes[HeroIconNames[Index]] = HeroIconPackedScenesArray[Index]

#Grabs an icon for that hero as a Sprite2D instance
func _GetIconInstanceOfType(HeroType):
	#return HeroIconPackedScenesArray[0].instantiate()#Chad Array Line
	return HeroIconPackedScenes[HeroType].instantiate()#Virgin Dictionary Line
