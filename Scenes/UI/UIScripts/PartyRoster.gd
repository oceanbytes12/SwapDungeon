extends Control

var Selected = false
@onready var EmptySlot = $RosterUI/MarginContainer/NewHeroContainer/EmptySlot
@export var partyContainer : GridContainer
var rosterPanel = preload("res://Michael WIP/GoodScenes/HeroRosterPanel.tscn")
signal onPartyAddedTo
var UpgradeableUnits = []

func _ready():
	HeroUiController.partyRoster = self

func _on_area_2d_mouse_entered():
	Selected = true

func _on_area_2d_mouse_exited():
	Selected = false

func addToParty(panel):
	emit_signal("onPartyAddedTo")
	
	HeroUiController.Purchase(panel.HeroType)
	
	if(UpgradeableUnits.size()> 0):
		var upgradedUnit = UpgradeableUnits[0]
		var UpgradeType = Globals.unitManager._GetUpgradedType(upgradedUnit.heroType)
		var newPanel = rosterPanel.instantiate()
		newPanel.InitializeWithHero(UpgradeType)
		partyContainer.add_child(newPanel)
		var index = upgradedUnit.get_index()
		partyContainer.move_child(newPanel, index)
		
		panel.HandleUsed()
		upgradedUnit.queue_free()
		
	else:
		var newPanel = rosterPanel.instantiate()
		newPanel.InitializeWithHero(panel.HeroType)
		partyContainer.add_child(newPanel)
		partyContainer.move_child(newPanel, 0)
		
		panel.HandleUsed()
	partyContainer.move_to_front()

func getPartyCount():
	return partyContainer.get_child_count() - 1

func find_Panels_Of_Type(heroType):
	var panels = []
	for panel in partyContainer.get_children():
		if(panel is HeroRosterPanel and panel.heroType == heroType):
			panels.append(panel)
	return panels

func _return_all_panels():
	for panel in partyContainer.get_children():
		if panel.has_method("ReturnPanel"):
			panel.ReturnPanel()

func _process(_delta):
	_check_upgrades()
	
func _check_upgrades():
	if(HeroUiController.draggedDraggableHeroPanel):
		UpgradeableUnits = find_Panels_Of_Type(HeroUiController.draggedDraggableHeroPanel.HeroType)
		for upgradeAbleUnit in UpgradeableUnits:
			upgradeAbleUnit.HighLight(true)
		if(UpgradeableUnits.size() > 0):
			HeroUiController.draggedDraggableHeroPanel.HighLight(true)
		else:
			HeroUiController.draggedDraggableHeroPanel.HighLight(false)
	else:
		UpgradeableUnits = []
		for panel in partyContainer.get_children():
			if(panel.has_method("HighLight")):
				panel.HighLight(false)
