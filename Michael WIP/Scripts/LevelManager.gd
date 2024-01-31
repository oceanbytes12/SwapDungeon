extends Node

class_name LevelManager

var levelFolder = "res://Scene/Levels/"
var levelIndex = 0
var levels = []

func _ready():
	levels = Globals._LoadPackedScenesInPath(levelFolder)
	#levels.sort_custom(CompareLevels)
	for level in levels:
		print(level.resource_path)

func CompareLevels(a,b):
	if(a.resource_path < b.resource_path):
		return true
	return false
	
func _GetNextLevel():
	if(levelIndex < levels.size()):
		return levels[levelIndex]

func _IncrementLevelIndex():
	levelIndex=levelIndex+1
