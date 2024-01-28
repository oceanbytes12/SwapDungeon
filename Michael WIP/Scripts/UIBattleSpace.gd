extends Control
class_name UIBattleSpace

var equippedPanel

func Target(isTargeted):
	if(isTargeted):
		scale = Vector2.ONE * 1.1
	else:
		scale = Vector2.ONE

func HandlePanel(addedPanel):
	equippedPanel = addedPanel
	print("Adding to battle space!")
	addedPanel._EquipPanelToBattleSpace(self)



func _on_area_2d_mouse_entered():
	Globals._SetSelectedBattleSpace(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedBattleSpace(null)

func GetHeroType():
	if(equippedPanel):
		return equippedPanel.heroType
