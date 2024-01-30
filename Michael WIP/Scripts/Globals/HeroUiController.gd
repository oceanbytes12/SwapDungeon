extends Node

var selectedDraggableHeroPanel : DraggableHeroPanel
var draggedDraggableHeroPanel : DraggableHeroPanel
var draggedRosterPanel : HeroRosterPanel
var selectedBattleSpace : UIBattleSpace
var selectedRosterPanel : HeroRosterPanel
var partyRoster 

func _process(_delta):
	if Input.is_action_just_pressed("LeftClick"):
		_HandleLeftClickDown()
	elif Input.is_action_just_released("LeftClick"):
		_HandleLeftClickUp()

func _HandleLeftClickDown():
	#DraggableHeroNewSystem
	if(is_instance_valid(selectedDraggableHeroPanel)):
		draggedDraggableHeroPanel = selectedDraggableHeroPanel
		draggedDraggableHeroPanel.ToggleDrag(true)
		
	if(is_instance_valid(selectedRosterPanel)):
		draggedRosterPanel = selectedRosterPanel
		draggedRosterPanel.ToggleDrag(true)
		
func _HandleLeftClickUp():
	#DraggableHeroNewSystem
	if(is_instance_valid(draggedDraggableHeroPanel)):
		draggedDraggableHeroPanel.ToggleDrag(false)
		if(partyRoster.Selected):
			partyRoster.addToParty(draggedDraggableHeroPanel)
		draggedDraggableHeroPanel = null
	
	if(is_instance_valid(draggedRosterPanel)):
		draggedRosterPanel.ToggleDrag(false)
		if(is_instance_valid(selectedBattleSpace)):
			selectedBattleSpace.HandlePanel(draggedRosterPanel)
		elif(partyRoster.Selected):
			draggedRosterPanel.ReturnPanel()
		draggedRosterPanel = null
		
func _SetDraggableAsNull():
	draggedDraggableHeroPanel = null

#Panels that let you add.
func _SetSelectedDraggableHeroPanel(newDraggableHeroPanel):
	if(is_instance_valid(draggedDraggableHeroPanel)):
		return
	
	#If there's a previous panel nerf it.
	if(selectedDraggableHeroPanel):
		selectedDraggableHeroPanel.Target(false)
	#Buff the new one.
	if(newDraggableHeroPanel):
		newDraggableHeroPanel.Target(true)
		
	selectedDraggableHeroPanel = newDraggableHeroPanel

#Panels in the roster
func _SetSelectedHeroRosterPanel(newRosterPanel):
	if(is_instance_valid(draggedRosterPanel)):
		return
	#If there's a previous panel nerf it.
	if(is_instance_valid(selectedRosterPanel)):
		selectedRosterPanel.Target(false)
	#Buff the new one.
	if(newRosterPanel):
		newRosterPanel.Target(true)
		
	selectedRosterPanel = newRosterPanel

#Panels in battle spaces
func _SetSelectedBattleSpace(newBattleSpace):
	if(!is_instance_valid(draggedRosterPanel)):
		return

	#If there's a previous panel nerf it.
	if(is_instance_valid(selectedBattleSpace)):
		selectedBattleSpace.Target(false)
	
	#Buff the new one.
	if(is_instance_valid(newBattleSpace)):
		newBattleSpace.Target(true)
		
	selectedBattleSpace = newBattleSpace

