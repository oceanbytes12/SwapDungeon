extends Node

var selectedDraggableHeroPanel : DraggableHeroPanel
var draggedDraggableHeroPanel : DraggableHeroPanel
var draggedRosterPanel : HeroRosterPanel
var selectedBattleSpace : UIBattleSpace
var selectedRosterPanel : HeroRosterPanel
var partyRoster 

func _process(delta):
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

