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
	
	var HeroIcon = Globals._GetIconInstanceOfType(heroType)
	FrontPanel.add_child(HeroIcon)
	HeroIcon.position += FrontPanel.size / 2
	
	var HeroIconBack = Globals._GetIconInstanceOfType(heroType)
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
	Globals._SetSelectedHeroRosterPanel(self)

func _on_area_2d_mouse_exited():
	print("Exited a roster panel")
	Globals._SetSelectedHeroRosterPanel(null)

func _process(delta):
	if(isDragged):
		#print("Is now dragged")
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _EquipPanelToBattleSpace(newBattleSpace):
	#Unequip from any battle space we might have occupied
	if(battleSpace):
		battleSpace.equippedPanel = null
	#Equip to the new battle space.
	FrontPanel.reparent(newBattleSpace)
	#Remember our battle space
	battleSpace = newBattleSpace

func ReturnPanel():
	if(battleSpace):
		battleSpace.equippedPanel = null
	FrontPanel.reparent(UIParent)
	battleSpace = null

func HighLight(isOn):
	HighlightPanel.visible = isOn
