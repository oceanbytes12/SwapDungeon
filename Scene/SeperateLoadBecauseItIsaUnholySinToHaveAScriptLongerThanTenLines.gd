extends Node

var level1 = preload("res://Scene/Levels/Level1.tscn")
var level2 = preload("res://Scene/Levels/Level2.tscn")
var level3 = preload("res://Scene/Levels/Level3.tscn")
var level4 = preload("res://Scene/Levels/NecroMancerBoss.tscn")
var level5 = preload("res://Scene/Levels/Level5.tscn")
var level6 = preload("res://Scene/Levels/Level6.tscn")
var level7 = preload("res://Scene/Levels/DeermanBoss.tscn")

func loadLevels():
	var levels = []
	levels.append(level1)
	levels.append(level2)
	levels.append(level3)
	levels.append(level4)
	levels.append(level5)
	levels.append(level6)
	levels.append(level7)
	return levels
