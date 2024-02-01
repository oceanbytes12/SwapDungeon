extends Node

class_name LevelManager


var levelIndex = 0
@export var levels:Array[PackedScene]
	
func _GetNextLevel():
	if(levelIndex < levels.size()):
		return levels[levelIndex]

func _IncrementLevelIndex():
	levelIndex=levelIndex+1
