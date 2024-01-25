extends Control

class_name HeroUI

var TargetPosition : Vector2
var hasTargetPostion = false
var isBeingDragged = false
var FOLLOW_SPEED = 10

var HeroType 
var HeroIcon

func _ready():
	HeroType = Globals._GetRandomHeroType()
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
		global_position = get_global_mouse_position()
	elif hasTargetPostion:
		global_position = global_position.lerp(TargetPosition, delta * FOLLOW_SPEED)
		
func ToggleDrag(isDragged):
	isBeingDragged = isDragged
	
	if(isDragged):
		TargetPosition = global_position
		hasTargetPostion = true

func _on_area_2d_mouse_entered():
	Globals._SetSelectedHero(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHero(null)
