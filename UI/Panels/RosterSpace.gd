extends Control

class_name HeroRosterPanel

@export var BackPanel : Control
@export var FrontPanel : Control
@export var UIParent : Control
@onready var HighlightPanel : Control = $ExpandInUI/HighLightPanel
var isDragged = false
var speed = 10
var data
var battleSpace
var Gray = Color(0.411765, 0.411765, 0.411765, 1) # Dim Gray
func ToggleDrag(newDragState):
	isDragged = newDragState

func InitializeWithHero(newHeroData):
	data = newHeroData
	
	var HeroIcon = Globals.unitManager.GetIcon(newHeroData)
	#var HeroIcon = heroData.HeroIcon.Instantiate()
	FrontPanel.add_child(HeroIcon)
	HeroIcon.position += FrontPanel.size / 2
	
	var HeroIconBack = Globals.unitManager.GetIcon(newHeroData)
	#var HeroIconBack = heroData.HeroIcon.Instantiate()
	HeroIconBack.modulate = Gray
	BackPanel.add_child(HeroIconBack)
	HeroIconBack.position += BackPanel.size / 2

func Target(isTargeted):
	if(isTargeted):
		FrontPanel.scale = Vector2.ONE * 1.1
	else:
		FrontPanel.scale = Vector2.ONE
	
func _on_area_2d_mouse_entered():
	Globals._SetSelectedHeroRosterPanel(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedHeroRosterPanel(null)

func _process(delta):
	if(isDragged):
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _EquipPanelToBattleSpace(newBattleSpace):
	#If the place we are going into already has a panel
	if(newBattleSpace.equippedPanel != null):
		#If we are coming in from a panel, swap
		if(battleSpace!= null):
			#Give the other panel our stuff
			var otherPanel = newBattleSpace.equippedPanel
			otherPanel.FrontPanel.reparent(battleSpace)
			otherPanel.battleSpace = battleSpace
			battleSpace.equippedPanel = otherPanel
			$Place_unit_sfx.play()
			#Equip ourselves to the new panel
			newBattleSpace.equippedPanel = self
			FrontPanel.reparent(newBattleSpace)
			battleSpace = newBattleSpace
	else:
		if(battleSpace):
			battleSpace.equippedPanel = null
		#Requip ourselves to the new battle space
		FrontPanel.reparent(newBattleSpace)
		battleSpace = newBattleSpace
	
func ReturnPanel():
	if(battleSpace):
		battleSpace.equippedPanel = null
	FrontPanel.reparent(UIParent)
	battleSpace = null

func HighLight(isOn):
	HighlightPanel.visible = isOn
