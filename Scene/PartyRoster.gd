extends Control

var Selected = false
@onready var EmptySlot = $RosterUI/MarginContainer/NewHeroContainer/EmptySlot
@export var partyContainer : GridContainer
var rosterPanel = preload("res://Michael WIP/GoodScenes/HeroRosterPanel.tscn")
signal onPartyAddedTo
var UpgradeableUnits = []

func _ready():
	Globals.partyRoster = self

func _on_area_2d_mouse_entered():
	Selected = true

func _on_area_2d_mouse_exited():
	Selected = false

func addToParty(panel):
	emit_signal("onPartyAddedTo")
	if(UpgradeableUnits.size()> 0):
		var upgradedUnit = UpgradeableUnits[0]
		var UpgradeType = Globals._GetUpgradedType(upgradedUnit.heroType)
		var newPanel = rosterPanel.instantiate()
		newPanel.InitializeWithHero(UpgradeType)
		partyContainer.add_child(newPanel)
		var index = panel.get_index()
		partyContainer.move_child(newPanel, index)
		panel.HandleUsed()
		upgradedUnit.queue_free()
		
	else:
		panel.HandleUsed()
		var newPanel = rosterPanel.instantiate()
		newPanel.InitializeWithHero(panel.HeroType)
		partyContainer.add_child(newPanel)
		partyContainer.move_child(newPanel, 0)
	partyContainer.move_to_front()

func find_Panels_Of_Type(heroType):
	var panels = []
	for panel in partyContainer.get_children():
		print("Panel: ",panel.name, "IsDraggable: " ,panel is DraggableHeroPanel)
		if(panel is HeroRosterPanel and panel.heroType == heroType):
			panels.append(panel)
	return panels

func _return_all_panels():
	for panel in partyContainer.get_children():
		if panel.has_method("ReturnPanel"):
			panel.ReturnPanel()

func _process(delta):
	_check_upgrades()
	
func _check_upgrades():
	if(Globals.draggedDraggableHeroPanel):
		UpgradeableUnits = find_Panels_Of_Type(Globals.draggedDraggableHeroPanel.HeroType)
		print("Upgradeable: ", UpgradeableUnits.size())
		for upgradeAbleUnit in UpgradeableUnits:
			upgradeAbleUnit.HighLight(true)
		if(UpgradeableUnits.size() > 0):
			Globals.draggedDraggableHeroPanel.HighLight(true)
		else:
			Globals.draggedDraggableHeroPanel.HighLight(false)
	else:
		UpgradeableUnits = []
		for panel in partyContainer.get_children():
			if(panel.has_method("HighLight")):
				panel.HighLight(false)
