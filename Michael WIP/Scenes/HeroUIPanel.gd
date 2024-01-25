extends Control

class_name HeroUIPanel

func _ready():
	call_deferred("_AddStartingHero")

func _on_area_2d_mouse_entered():
	Globals._SetSelectedHeroPanel(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHeroPanel(null)

func GetHeldHero() -> HeroUI:
	return Globals._GetChildNodeOfType(self, HeroUI) as HeroUI

func _AddStartingHero():
	if(GetHeldHero()):
		GetHeldHero().position = Vector2.ZERO

func _AddHero(newHero):
	#If we had a hero,
	#Inform them to go where the new hero was.
	if(GetHeldHero()):
		var newHeroParent = newHero.get_parent()
		if(newHeroParent!=null):
			print("Reparenting Held Hero")
			GetHeldHero().reparent(newHeroParent)
		else:
			print("Can't reparent held hero, new hero has no parent.")

	print("Reparenting New Hero")
	newHero.reparent(self)
	
	print(name, " is now holding: ", GetHeldHero())
