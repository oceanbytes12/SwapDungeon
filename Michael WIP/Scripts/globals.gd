extends Node

var isDragging = false

#OldSystem
var selectedHero : HeroUI
var draggedHero : HeroUI
var selectedPanel : HeroUIPanel
var heroIconScenes = []
var spawnPositions = []
var path = "res://Michael WIP/HeroIcons/"

#New System
var selectedDraggableHeroPanel : DraggableHeroPanel
var draggedDraggableHeroPanel : DraggableHeroPanel
var draggedRosterPanel : HeroRosterPanel
var selectedBattleSpace : UIBattleSpace
var selectedRosterPanel : HeroRosterPanel
var partyRoster 

#Other
var AlexTester

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

func _GetUpgradedType(heroType):
	var index = heroType as int
	return _GetUpgradedHeroTypeAtIndex(index)

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

func _process(delta):
	#if(draggedDraggableHeroPanel):
		#print("draggedDraggableHeroPanel is, ", draggedDraggableHeroPanel)
	if Input.is_action_just_pressed("LeftClick"):
		_HandleLeftClickDown()
	elif Input.is_action_just_released("LeftClick"):
		_HandleLeftClickUp()

func _HandleLeftClickDown():
	#DraggableHeroNewSystem
	if(selectedDraggableHeroPanel):
		print("Starting Drag1!")
		draggedDraggableHeroPanel = selectedDraggableHeroPanel
		draggedDraggableHeroPanel.ToggleDrag(true)
		
	if(selectedRosterPanel):
		print("Starting Drag2")
		draggedRosterPanel = selectedRosterPanel
		draggedRosterPanel.ToggleDrag(true)
		
func _HandleLeftClickUp():
	#DraggableHeroNewSystem
	if(draggedDraggableHeroPanel):
		draggedDraggableHeroPanel.ToggleDrag(false)
		if(partyRoster.Selected):
			partyRoster.addToParty(draggedDraggableHeroPanel)
		draggedDraggableHeroPanel = null
	
	if(draggedRosterPanel):
		draggedRosterPanel.ToggleDrag(false)
		if(selectedBattleSpace):
			selectedBattleSpace.HandlePanel(draggedRosterPanel)
		elif(partyRoster.Selected):
			draggedRosterPanel.ReturnPanel()
		draggedRosterPanel = null
		
func _GetChildNodeOfType(parent, DesiredClass, allowInvisible = false):
	var desired_children = []
	for child in parent.get_children():
		if is_instance_of(child, DesiredClass):
			if(allowInvisible or child.visible):
				return child

func _SetDraggableAsNull():
	draggedDraggableHeroPanel = null

#Panels that let you add.
func _SetSelectedDraggableHeroPanel(newDraggableHeroPanel):
	print("Setting Selected Draggable: ", newDraggableHeroPanel)
	if(draggedDraggableHeroPanel):
		print("But we won't as we are dragging something.")
		return
	#print("Setting Target Panel", newPanel)
	
	#If there's a previous panel nerf it.
	if(selectedDraggableHeroPanel):
		selectedDraggableHeroPanel.Target(false)
	#Buff the new one.
	if(newDraggableHeroPanel):
		newDraggableHeroPanel.Target(true)
		
	selectedDraggableHeroPanel = newDraggableHeroPanel

#Panels in the roster
func _SetSelectedHeroRosterPanel(newRosterPanel):
	print("Setting Selected Draggable: ", newRosterPanel)
	if(draggedRosterPanel):
		print("But we won't as we are dragging something.")
		return
	#If there's a previous panel nerf it.
	if(selectedRosterPanel):
		selectedRosterPanel.Target(false)
	#Buff the new one.
	if(newRosterPanel):
		newRosterPanel.Target(true)
		
	selectedRosterPanel = newRosterPanel

#Panels in battle spaces
func _SetSelectedBattleSpace(newBattleSpace):
	print("Setting Selected Draggable: ", newBattleSpace)
	
	if(!draggedRosterPanel):
		print("We aren't dragging a roster panel, don't care about battle spaces.")
		return

	#If there's a previous panel nerf it.
	if(is_instance_valid(selectedBattleSpace)):
		selectedBattleSpace.Target(false)
	
	#Buff the new one.
	if(is_instance_valid(newBattleSpace)):
		newBattleSpace.Target(true)
		
	selectedBattleSpace = newBattleSpace

func _kill_all_enemies():
	if(is_instance_valid(AlexTester)):
		AlexTester._kill_all_enemies()

func _kill_all_players():
	if(is_instance_valid(AlexTester)):
		AlexTester._kill_all_players()

func EnemiesAreDead():
	if(is_instance_valid(AlexTester)):
		return AlexTester.EnemiesAreDead()
	return false

func PlayersAreDead():
	if(is_instance_valid(AlexTester)):
		return AlexTester.PlayersAreDead()
	return false
