extends Node

@export var level1 : PackedScene
@export var level2 : PackedScene
@export var level3 : PackedScene
@export var level4 : PackedScene
@export var level5 : PackedScene


func loadLevels():
	var levels = []
	levels.append(level1)
	levels.append(level2)
	levels.append(level3)
	levels.append(level4)
	levels.append(level5)
	return levels
