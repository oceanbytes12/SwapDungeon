extends Node

class_name LevelManager

var levelFolder = "res://Scene/Levels/"
var levelIndex = 0
var levels = []

func _ready():
	levels = Globals._LoadPackedScenesInPath(levelFolder)

func _GetNextLevel():
	if(levelIndex < levels.size()):
		return levels[levelIndex]

func _IncrementLevelIndex():
	levelIndex=levelIndex+1
