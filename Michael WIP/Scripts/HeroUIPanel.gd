extends Control

class_name HeroUIPanel

@onready var heroUIScene = preload("res://Michael WIP/GoodScenes/Hero_UI.tscn")

signal onEmptyHeroPanelFilled

func _spawnHeroUI():
	print("Spawning Hero UI")
	var newHero = heroUIScene.instantiate()
	newHero._generateRandomHero()
	add_child(newHero)
	newHero.position = Vector2.ZERO

func _despawnHeroUI():
	if(GetHeldHero()):
		GetHeldHero().queue_free()

func _on_area_2d_mouse_entered():
	Globals._SetSelectedHeroPanel(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHeroPanel(null)

func GetHeldHero() -> HeroUI:
	return Globals._GetChildNodeOfType(self, HeroUI) as HeroUI

#When you add a hero to this tile this is called.
func _AddHero(newHero):
	print("Adding Hero: ", newHero.name)
	#If we had a hero,
	#Inform them to go where the new hero was.
	if(GetHeldHero() != null):
		if(GetHeldHero().HeroType != newHero.HeroType):
			_HandleSwap(newHero)
		elif(GetHeldHero() != newHero):
			_HandleCombine(newHero)
	
	else:
		print("EmptyHeroPanelFilled")
		if(!newHero.usedByParty):
			newHero.usedByParty = true
			emit_signal("onEmptyHeroPanelFilled")

	print("Reparenting New Hero")
	newHero.reparent(self)
	
	print(name, " is now holding: ", GetHeldHero())

#When adding a hero results in an upgrade
func _HandleCombine(addedHero):
	print("Handling Combine!")
	#We have two heros. Grab the upgrade
	var newType = Globals._GetUpgradedHeroTypeAtIndex(addedHero.HeroType as int)
	#Destroy them both 
	_despawnHeroUI()
	if(addedHero):
		addedHero.queue_free()
	#Grab a new Hero
	var newHero = heroUIScene.instantiate()
	#Make it make a hero of the upgrade type
	newHero._CreateHeroOfType(newType)
	
	#Position it properly
	add_child(newHero)
	call_deferred("_MoveStartingHero")

#When adding a hero results in a swap
func _HandleSwap(newHero):
	var newHeroParent = newHero.get_parent()
	if(newHeroParent!=null):
		print("Reparenting Held Hero")
		GetHeldHero().reparent(newHeroParent)
	else:
		print("Can't reparent held hero, new hero has no parent.")
