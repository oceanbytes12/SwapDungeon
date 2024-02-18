extends Node

const warrior1Index = 0
const warrior2Index = 1

const archer1Index = 2
const archer2Index = 3

const mage1Index = 4
const mage2Index = 5

const rogue1Index = 6
const rogue2Index = 7

const paladin1Index = 8
const paladin2Index = 9

const druid1Index = 10
const druid2Index = 11

const priest1Index = 12
const priest2Index = 13

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
var priest2Icon = preload("res://Michael WIP/HeroIcons/HeroIconPriest2.tscn")



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
var priest2 = preload("res://Scenes/Units/Players/Priest2.tscn")


var level1 = preload("res://Scene/Levels/Level1.tscn")
var level2 = preload("res://Scene/Levels/Level2.tscn")
var level3 = preload("res://Scene/Levels/Level3.tscn")
var level4 = preload("res://Scene/Levels/NecroMancerBoss.tscn")
var level5 = preload("res://Scene/Levels/Level5.tscn")
var level6 = preload("res://Scene/Levels/Level6.tscn")
var level7 = preload("res://Scene/Levels/DeermanBoss.tscn")

func loadIcons():
	var heroIcons = {}
	heroIcons[warrior1Index] = warrior1Icon
	heroIcons[warrior2Index] = warrior2Icon
	
	heroIcons[archer1Index] = aracher1Icon
	heroIcons[archer2Index] = aracher2Icon
	
	heroIcons[mage1Index] = mage1Icon
	heroIcons[mage2Index] = mage2Icon
	
	heroIcons[rogue1Index] = rogue1Icon
	heroIcons[rogue2Index] = rogue2Icon
	
	heroIcons[paladin1Index] = paladin1Icon
	heroIcons[paladin2Index] = paladin2Icon
	
	heroIcons[druid1Index] = druid1Icon
	heroIcons[druid2Index] = druid2Icon
	
	heroIcons[priest1Index] = priest1Icon
	heroIcons[priest2Index] = priest2Icon
	
	return heroIcons

func loadUnits():
	var units = {}
	units[warrior1Index] = warrior1
	units[warrior2Index] = warrior2
	units[archer1Index] = archer1
	units[archer2Index] = archer2
	units[mage1Index] = mage1
	units[mage2Index] = mage2
	units[rogue1Index] = rogue1
	units[rogue2Index] = rogue2
	units[paladin1Index] = paladin1
	units[paladin2Index] = paladin2
	units[druid1Index] = druid1
	units[druid2Index] = druid2	
	units[priest1Index] = priest1
	units[priest2Index] = priest2
	return units

func loadUnupgradedUnits():
	var unupgradedUnits = {}
	
	unupgradedUnits[warrior1Index] = warrior1
	unupgradedUnits[archer1Index] = archer1
	unupgradedUnits[mage1Index] = mage1
	unupgradedUnits[rogue1Index] = rogue1
	unupgradedUnits[paladin1Index] = paladin1
	unupgradedUnits[druid1Index] = druid1
	unupgradedUnits[priest1Index] = priest1
	
	return unupgradedUnits

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

func loadCosts():
	var Costs = {}
	Costs[warrior1Index] = 6
	Costs[archer1Index] = 8
	Costs[mage1Index] = 7
	Costs[rogue1Index] = 5
	Costs[warrior2Index] = 12
	Costs[archer2Index] = 16
	Costs[mage2Index] = 14
	Costs[paladin1Index] = 8
	Costs[paladin2Index] = 14
	Costs[druid1Index] = 8
	Costs[druid2Index] = 16
	Costs[priest1Index] = 8
	Costs[priest2Index] = 14
	return Costs
