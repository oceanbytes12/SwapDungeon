extends Node

enum HeroTypes 
{ 
	Warrior1 = 0, 
	Mage1 = 1,
	Archer1 = 2 
}

enum UpgradedHeroTypes
{
	Warrior2 = 0,
	Mage2 = 1,
	Archer2 = 2
}

#Returns a random hero type from those in the game.
func _GetRandomHeroType():
	var randomIndex = randi() % HeroTypes.size()
	return _GetHeroTypeAtIndex(randomIndex)

func _GetHeroTypeAtIndex(index):
	return HeroTypes.keys()[index]

func _GetUpgradedHeroTypeAtIndex(index):
	return UpgradedHeroTypes.keys()[index]

func _GetUpgradedType(heroType):
	var index = heroType as int
	return _GetUpgradedHeroTypeAtIndex(index)
