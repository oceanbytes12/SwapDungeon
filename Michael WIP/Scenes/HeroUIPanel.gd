extends Control

class_name HeroUIPanel

@export var HeldHero : HeroUI

func _ready():
	call_deferred("_AddStartingHero")

func _on_area_2d_mouse_entered():
	Globals._SetSelectedHeroPanel(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHeroPanel(null)

func _AddStartingHero():
	if(HeldHero):
		HeldHero.TargetPosition = global_position
		HeldHero.hasTargetPostion = true
		HeldHero.global_position = global_position

func _AddHero(newHero):
	#If we had a hero,
	#Inform them to go where the new hero was.
	if(HeldHero):
		HeldHero.TargetPosition = newHero.TargetPosition
		var newHeroParent = newHero.get_parent()
		if(newHeroParent!=null):
			print("Reparenting Held Hero")
			HeldHero.reparent(newHeroParent)
		else:
			print("Can't reparent held hero, new hero has no parent.")
	
	print("Reparenting New Hero")
	newHero.reparent(self)
	
	#Add the current hero.
	newHero.hasTargetPostion = true
	newHero.TargetPosition = global_position
	
	HeldHero = newHero
