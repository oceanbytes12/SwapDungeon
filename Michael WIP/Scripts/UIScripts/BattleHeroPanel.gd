extends Control
class_name UIBattleSpace

var equippedPanel

func Target(isTargeted):
	if(isTargeted):
		scale = Vector2.ONE * 1.1
	else:
		scale = Vector2.ONE

func HandlePanel(addedPanel):
	addedPanel._EquipPanelToBattleSpace(self)
	equippedPanel = addedPanel


func _on_area_2d_mouse_entered():
	Globals._SetSelectedBattleSpace(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedBattleSpace(null)

func GetHeroType():
	if(is_instance_valid(equippedPanel)):
		return equippedPanel.heroType
