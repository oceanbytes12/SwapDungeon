extends Control

class_name DraggableHeroPanel

@onready var FrontPanel : Control = $Front_Panel
@onready var BackPanel : Control = $Back_Panel
@onready var HighlightPanel : Control = $Front_Panel/HighLightPanel

var speed = 10
var isDragged = false
signal dragStateChange(old_value, new_value)
var HeroType 
var HeroIcon
@export var CreateRandomHero : bool = false

func _ready():
	if(CreateRandomHero):
		_generateRandomHero()

func ToggleDrag(newDragState):
	dragStateChange.emit(isDragged, newDragState)
	isDragged = newDragState
	
	if(!isDragged):
		HighLight(false)

func Target(isTargeted):
	if(isTargeted):
		FrontPanel.scale = Vector2.ONE * 1.1
	else:
		FrontPanel.scale = Vector2.ONE

func _process(delta):
	if(isDragged):
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _on_area_2d_mouse_entered():
	HeroUiController._SetSelectedDraggableHeroPanel(self)

func _on_area_2d_mouse_exited():
	HeroUiController._SetSelectedDraggableHeroPanel(null)

func _generateRandomHero():
	_CreateHeroOfType(Globals.unitManager._GetRandomUnupgradedType())

func _CreateHeroOfType(NewHeroType):
	HeroType = NewHeroType
	
	HeroIcon = HeroIconController._GetIconInstanceOfType(HeroType)
	if(HeroIcon):
		var TargetChild = FrontPanel.get_child(0)
		TargetChild.add_child(HeroIcon)
		HeroIcon.position = Vector2.ZERO + TargetChild.size / 2
		
	else:
		print("Failed to get a random hero.")
	
	var randomHeroNum = RandomNumberGenerator.new().randf()
	name = HeroType + str(randomHeroNum)

func HandleUsed():
	mouse_filter =Control.MOUSE_FILTER_IGNORE
	HeroUiController._SetDraggableAsNull()
	HeroUiController._SetSelectedDraggableHeroPanel(null)
	
	set_process(false)
	if(is_instance_valid(FrontPanel)):
		FrontPanel.queue_free()

func HighLight(isOn):
	HighlightPanel.visible = isOn
