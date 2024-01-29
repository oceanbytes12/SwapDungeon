extends Node

enum HeroTypes 
{ 
	Warrior = 0, 
	Mage = 1,
	Archer = 2 
}

enum UpgradedHeroTypes
{
	Maurader = 0,
	ArchWizard = 1,
	Sniper = 2
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
