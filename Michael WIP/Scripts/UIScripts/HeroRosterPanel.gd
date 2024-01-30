extends Control

class_name HeroRosterPanel

@export var BackPanel : Control
@export var FrontPanel : Control
@export var UIParent : Control
@onready var HighlightPanel : Control = $ExpandInUI/HighLightPanel
var isDragged = false
var speed = 10
var heroType
var battleSpace
func ToggleDrag(newDragState):
	print("Drag Toggle")
	isDragged = newDragState

func InitializeWithHero(newHeroType):
	
	heroType = newHeroType
	
	var HeroIcon = HeroIconController._GetIconInstanceOfType(heroType)
	FrontPanel.add_child(HeroIcon)
	HeroIcon.position += FrontPanel.size / 2
	
	var HeroIconBack = HeroIconController._GetIconInstanceOfType(heroType)
	HeroIconBack.modulate= Color(0.411765, 0.411765, 0.411765, 1) # Dim Gray
	BackPanel.add_child(HeroIconBack)
	HeroIconBack.position += BackPanel.size / 2

func Target(isTargeted):
	if(isTargeted):
		FrontPanel.scale = Vector2.ONE * 1.1
	else:
		FrontPanel.scale = Vector2.ONE
	
func _on_area_2d_mouse_entered():
	print("Entered a roster panel")
	HeroUiController._SetSelectedHeroRosterPanel(self)

func _on_area_2d_mouse_exited():
	print("Exited a roster panel")
	HeroUiController._SetSelectedHeroRosterPanel(null)

func _process(delta):
	if(isDragged):
		#print("Is now dragged")
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _EquipPanelToBattleSpace(newBattleSpace):
	print("Attempting to equip!")
	#If the place we are going into already has a panel
	if(newBattleSpace.equippedPanel != null):
		print("Going in to an equipped panel.")
		#If we are coming in from a panel, swap
		if(battleSpace!= null):
			print("Going in Empty")
			#Give the other panel our stuff
			var otherPanel = newBattleSpace.equippedPanel
			otherPanel.FrontPanel.reparent(battleSpace)
			otherPanel.battleSpace = battleSpace
			battleSpace.equippedPanel = otherPanel
			
			#Equip ourselves to the new panel
			newBattleSpace.equippedPanel = self
			FrontPanel.reparent(newBattleSpace)
			battleSpace = newBattleSpace
	else:
		print("Going in Empty2")
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
