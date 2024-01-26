extends Control

class_name HeroUI

var isBeingDragged = false
var FOLLOW_SPEED = 10
var HeroType 
var HeroIcon
var usedByParty = false

func _generateRandomHero():
	_CreateHeroOfType(Globals._GetRandomHeroType())

func _CreateHeroOfType(NewHeroType):
	HeroType = NewHeroType
	
	HeroIcon = Globals._GetIconInstanceOfType(HeroType)
	if(HeroIcon):
		#print("Made an icon of a random hero!")
		add_child(HeroIcon)
		HeroIcon.position = Vector2.ZERO
	else:
		print("Failed to get a random hero.")
	var randomHeroNum = RandomNumberGenerator.new().randf()
	name = HeroType + str(randomHeroNum)

func _process(delta):
	if(isBeingDragged):
		HeroIcon.z_index = 1000
		global_position = get_global_mouse_position()
	else:
		HeroIcon.z_index = 1
		position = position.lerp(Vector2.ZERO, delta * FOLLOW_SPEED)

func ToggleDrag(isDragged):
	isBeingDragged = isDragged

func _on_area_2d_mouse_entered():
	Globals._SetSelectedHero(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHero(null)
