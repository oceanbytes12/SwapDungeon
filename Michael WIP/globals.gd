extends Node

var isDragging = false
var selectedHero : HeroUI
var draggedHero : HeroUI
var selectedPanel : HeroUIPanel
var heroIconScenes = []
var spawnPositions = []
var path = "res://Michael WIP/HeroIcons/"
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
	var randomIndex = randi() % Globals.HeroTypes.size()
	return _GetHeroTypeAtIndex(randomIndex)

func _GetHeroTypeAtIndex(index):
	return HeroTypes.keys()[index]

func _GetUpgradedHeroTypeAtIndex(index):
	return UpgradedHeroTypes.keys()[index]

#Grabs an icon for that hero as a Sprite2D instance
func _GetIconInstanceOfType(HeroType):
	for HeroIcon in heroIconScenes:
		if(HeroIcon.resource_path.contains(HeroType)):
			#print("Found an icon for: ", HeroType)
			return HeroIcon.instantiate()
		else:
			#print("No find here: ", HeroType)
			pass

func _ready():
	_LoadHeroIconPackedScenes()

func _LoadHeroIconPackedScenes():
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
	
	if(selectedHero != null):
		selectedHero.scale = Vector2.ONE
		
	if(newHero != null):
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

func _GetChildNodeOfType(parent, DesiredClass, allowInvisible = false):
	var desired_children = []
	for child in parent.get_children():
		if is_instance_of(child, DesiredClass):
			if(allowInvisible or child.visible):
				return child
