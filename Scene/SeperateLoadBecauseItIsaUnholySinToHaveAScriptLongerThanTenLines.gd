extends Node

var warrior1Icon = preload("res://Michael WIP/HeroIcons/HeroIconWarrior1.tscn")
var warrior2Icon = preload("res://Michael WIP/HeroIcons/HeroIconWarrior2.tscn")
var aracher1Icon = preload("res://Michael WIP/HeroIcons/HeroIconArcher1.tscn")
var aracher2Icon = preload("res://Michael WIP/HeroIcons/HeroIconArcher2.tscn")
var mage1Icon = preload("res://Michael WIP/HeroIcons/HeroIconMage1.tscn")
var mage2Icon = preload("res://Michael WIP/HeroIcons/HeroIconMage2.tscn")

var warrior1 = preload("res://Scenes/Units/Players/Warrior1.tscn")
var warrior2 = preload("res://Scenes/Units/Players/Warrior2.tscn")
var archer1 = preload("res://Scenes/Units/Players/Archer1.tscn")
var archer2 = preload("res://Scenes/Units/Players/Archer2.tscn")
var mage1 = preload("res://Scenes/Units/Players/Mage1.tscn")
var mage2 = preload("res://Scenes/Units/Players/Mage2.tscn")

var level1 = preload("res://Scene/Levels/Level1.tscn")
var level2 = preload("res://Scene/Levels/Level2.tscn")
var level3 = preload("res://Scene/Levels/Level3.tscn")
var level4 = preload("res://Scene/Levels/Level4.tscn")

func loadIcons():
	var heroIcons = {}
	heroIcons["warrior1"] = warrior1Icon
	heroIcons["warrior2"] = warrior2Icon
	heroIcons["archer1"] = aracher1Icon
	heroIcons["archer2"] = aracher2Icon
	heroIcons["mage1"] = mage1Icon
	heroIcons["mage2"] = mage2Icon
	return heroIcons

func loadUnits():
	var units = {}
	units["warrior1"] = warrior1
	units["warrior2"] = warrior2
	units["archer1"] = archer1
	units["archer2"] = archer2
	units["mage1"] = mage1
	units["mage2"] = mage2
	return units

func loadUnupgradedUnits():
	var unupgradedUnits = {}
	unupgradedUnits["warrior1"] = warrior1
	unupgradedUnits["archer1"] = archer1
	unupgradedUnits["mage1"] = mage1
	return unupgradedUnits

func loadLevels():
	var levels = []
	levels.append(level1)
	levels.append(level2)
	levels.append(level3)
	levels.append(level4)
	return levels
