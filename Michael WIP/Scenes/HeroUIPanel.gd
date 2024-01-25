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

func _AddHero(hero):
	#If we had a hero,
	#Inform them to go where the new hero was.
	if(HeldHero):
		HeldHero.TargetPosition = hero.TargetPosition
	
	hero.reparent(self)
	
	#Add the current hero.
	hero.hasTargetPostion = true
	hero.TargetPosition = global_position
	
	HeldHero = hero
