extends Control

class_name DraggableHeroPanel

@onready var heroUIScene = preload("res://Michael WIP/GoodScenes/Hero_UI.tscn")
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
	print("Ready!")
	if(CreateRandomHero):
		_generateRandomHero()

func ToggleDrag(newDragState):
	print("Drag Toggle")
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
		#print("Is now dragged")
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		#print("Returning to HeroSlot" )
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _on_area_2d_mouse_entered():
	print("Mouse Entered")
	Globals._SetSelectedDraggableHeroPanel(self)

func _on_area_2d_mouse_exited():
	#print("MouseExited")
	Globals._SetSelectedDraggableHeroPanel(null)

func _generateRandomHero():
	_CreateHeroOfType(Globals._GetRandomHeroType())

func _CreateHeroOfType(NewHeroType):
	print("Creating random hero!")
	HeroType = NewHeroType
	
	HeroIcon = Globals._GetIconInstanceOfType(HeroType)
	if(HeroIcon):
		#print("Made an icon of a random hero!")
		var TargetChild = FrontPanel.get_child(0)
		TargetChild.add_child(HeroIcon)
		HeroIcon.position = Vector2.ZERO + TargetChild.size / 2
		
	else:
		print("Failed to get a random hero.")
	
	var randomHeroNum = RandomNumberGenerator.new().randf()
	name = HeroType + str(randomHeroNum)

func HandleUsed():
	mouse_filter =Control.MOUSE_FILTER_IGNORE
	Globals._SetDraggableAsNull()
	Globals._SetSelectedDraggableHeroPanel(null)
	
	set_process(false)
	if(is_instance_valid(FrontPanel)):
		FrontPanel.queue_free()

func HighLight(isOn):
	HighlightPanel.visible = isOn
