extends Node

var isDragging = false
var selectedHero : HeroUI
var draggedHero : HeroUI
var selectedPanel : HeroUIPanel

var heroIconScenes = []
var heroIconInstances = []

enum HeroTypes { 
	Warrior = 0, 
	Mage = 1 
}

#Returns a random hero type from those in the game.
func _GetRandomHeroType():
	var randomIndex = randi() % Globals.HeroTypes.size()
	return Globals.HeroTypes.keys()[randomIndex]

#Grabs an icon for that hero as a Sprite2D instance
func _GetIconInstanceOfType(HeroType):
	for HeroIcon in heroIconScenes:
		if(HeroIcon.resource_path.contains(HeroType)):
			print("Found an icon for: ", HeroType)
			return HeroIcon.instantiate()
		else:
			print("No find here: ", HeroType)

func _ready():
	_LoadHeroIconPackedScenes()

func _LoadHeroIconPackedScenes():
	var path = "res://Scene/HeroIcons/"
	var dir = DirAccess.open(path) 
	dir.open(path)
	
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif file_name.ends_with(".tscn"):
			#if !file_name.ends_with(".import"):
			heroIconScenes.append(load(path + "/" + file_name))
	dir.list_dir_end()

func _SetSelectedHero(newHero):
	#print("Setting Target Hero: ", newHero)
	
	if(selectedHero):
		selectedHero.scale = Vector2.ONE
		
	if(newHero):
		newHero.scale = Vector2.ONE * 1.1
	
	selectedHero = newHero

func _SetSelectedHeroPanel(newPanel):
	#print("Setting Target Panel", newPanel)
	
	#If there's a previous panel nerf it.
	if(selectedPanel):
		selectedPanel.scale = Vector2.ONE
	#Buff the new one.
	if(newPanel):
		newPanel.scale = Vector2.ONE * 1.1
		
	selectedPanel = newPanel

func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		_HandleLeftClickDown()
	elif Input.is_action_just_released("LeftClick"):
		_HandleLeftClickUp()

func _HandleLeftClickDown():
	if(selectedHero):
		draggedHero = selectedHero
		draggedHero.ToggleDrag(true)

func _HandleLeftClickUp():
	if(draggedHero):
		draggedHero.ToggleDrag(false)
		if(selectedPanel):
			selectedPanel._AddHero(draggedHero)
		draggedHero = null
