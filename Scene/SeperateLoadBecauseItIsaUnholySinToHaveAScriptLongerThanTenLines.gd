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
	var heroIcons = []
	
	heroIcons.append(warrior1Icon)
	heroIcons.append(warrior2Icon)
	
	heroIcons.append(aracher1Icon)
	heroIcons.append(aracher2Icon)
	
	heroIcons.append(mage1Icon)
	heroIcons.append(mage2Icon)
	
	heroIcons.append(rogue1Icon)
	heroIcons.append(rogue2Icon)
	
	heroIcons.append(paladin1Icon)
	heroIcons.append(paladin2Icon)
	
	heroIcons.append(druid1Icon)
	heroIcons.append(druid2Icon)
	
	heroIcons.append(priest1Icon)
	heroIcons.append(priest2Icon)
	
	return heroIcons

func loadBasicIcons():
	var heroIcons = []
	
	heroIcons.append(warrior1Icon)
	
	heroIcons.append(aracher1Icon)
	
	heroIcons.append(mage1Icon)
	
	heroIcons.append(rogue1Icon)
	
	heroIcons.append(paladin1Icon)
	
	heroIcons.append(druid1Icon)
	
	heroIcons.append(priest1Icon)

	return heroIcons

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
