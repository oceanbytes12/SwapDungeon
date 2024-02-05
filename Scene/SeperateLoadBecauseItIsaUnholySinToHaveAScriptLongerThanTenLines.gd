extends Node

var warrior1Icon = preload("res://Michael WIP/HeroIcons/HeroIconWarrior1.tscn")
var warrior2Icon = preload("res://Michael WIP/HeroIcons/HeroIconWarrior2.tscn")
var aracher1Icon = preload("res://Michael WIP/HeroIcons/HeroIconArcher1.tscn")
var aracher2Icon = preload("res://Michael WIP/HeroIcons/HeroIconArcher2.tscn")
var mage1Icon = preload("res://Michael WIP/HeroIcons/HeroIconMage1.tscn")
var mage2Icon = preload("res://Michael WIP/HeroIcons/HeroIconMage2.tscn")
var rogue1Icon = preload("res://Michael WIP/HeroIcons/HeroIconRouge1.tscn")
var rogue2Icon = preload("res://Michael WIP/HeroIcons/HeroIconRouge2.tscn")
var paladin1Icon = preload("res://Michael WIP/HeroIcons/HeroIconPaladin1.tscn")
var paladin2Icon = preload("res://Michael WIP/HeroIcons/HeroIconPaladin2.tscn")
var druid1Icon = preload("res://Michael WIP/HeroIcons/HeroIconDruid1.tscn")
var druid2Icon = preload("res://Michael WIP/HeroIcons/HeroIconDruid2.tscn")
var priest1Icon = preload("res://Michael WIP/HeroIcons/HeroIconPriest1.tscn")



var warrior1 = preload("res://Scenes/Units/Players/Warrior1.tscn")
var warrior2 = preload("res://Scenes/Units/Players/Warrior2.tscn")
var archer1 = preload("res://Scenes/Units/Players/Archer1.tscn")
var archer2 = preload("res://Scenes/Units/Players/Archer2.tscn")
var mage1 = preload("res://Scenes/Units/Players/Mage1.tscn")
var mage2 = preload("res://Scenes/Units/Players/Mage2.tscn")
var rogue1 = preload("res://Scenes/Units/Players/Rogue1.tscn")
var rogue2 = preload("res://Scenes/Units/Players/Rogue2.tscn")
var paladin1 = preload("res://Scenes/Units/Players/Paladin1.tscn")
var paladin2 = preload("res://Scenes/Units/Players/Paladin2.tscn")
var druid1 = preload("res://Scenes/Units/Players/Druid1.tscn")
var druid2 = preload("res://Scenes/Units/Players/Druid2.tscn")
var priest1 = preload("res://Scenes/Units/Players/Priest1.tscn")


var level1 = preload("res://Scene/Levels/Level1.tscn")
var level2 = preload("res://Scene/Levels/Level2.tscn")
var level3 = preload("res://Scene/Levels/Level3.tscn")
var level4 = preload("res://Scene/Levels/NecroMancerBoss.tscn")

func loadIcons():
	var heroIcons = {}
	heroIcons["warrior1"] = warrior1Icon
	heroIcons["warrior2"] = warrior2Icon
	heroIcons["archer1"] = aracher1Icon
	heroIcons["archer2"] = aracher2Icon
	heroIcons["mage1"] = mage1Icon
	heroIcons["mage2"] = mage2Icon
	heroIcons["rogue1"] = rogue1Icon
	heroIcons["rogue2"] = rogue2Icon
	heroIcons["paladin1"] = paladin1Icon
	heroIcons["paladin2"] = paladin2Icon
	heroIcons["druid1"] = druid1Icon
	heroIcons["druid2"] = druid2Icon
	heroIcons["priest1"] = priest1Icon
	return heroIcons

func loadUnits():
	var units = {}
	units["warrior1"] = warrior1
	units["warrior2"] = warrior2
	units["archer1"] = archer1
	units["archer2"] = archer2
	units["mage1"] = mage1
	units["mage2"] = mage2
	units["rogue1"] = rogue1
	units["rogue2"] = rogue2
	units["paladin1"] = paladin1
	units["paladin2"] = paladin2
	units["druid1"] = druid1
	units["druid2"] = druid2	
	units["priest1"] = priest1
	return units

func loadUnupgradedUnits():
	var unupgradedUnits = {}
	unupgradedUnits["warrior1"] = warrior1
	unupgradedUnits["archer1"] = archer1
	unupgradedUnits["mage1"] = mage1
	unupgradedUnits["rogue1"] = rogue1
	unupgradedUnits["paladin1"] = paladin1
	unupgradedUnits["druid1"] = druid1
	unupgradedUnits["priest1"] = priest1
	return unupgradedUnits

func loadLevels():
	var levels = []
	levels.append(level1)
	levels.append(level2)
	levels.append(level3)
	levels.append(level4)
	return levels

func loadCosts():
	var Costs = {}
	Costs["warrior1"] = 6
	Costs["archer1"] = 8
	Costs["mage1"] = 7
	Costs["rogue1"] = 5
	Costs["warrior2"] = 12
	Costs["archer2"] = 16
	Costs["mage2"] = 14
	Costs["paladin1"] = 8
	Costs["druid1"] = 8
	Costs["druid2"] = 16
	Costs["priest1"] = 8
	return Costs
