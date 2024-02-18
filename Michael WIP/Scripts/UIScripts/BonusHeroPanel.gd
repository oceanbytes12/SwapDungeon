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
var data : HeroData
var Gray = Color(0.411765, 0.411765, 0.411765, 1)

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
	if(Globals.moneyManager.money < GetCost()):
		FrontPanel.modulate = Gray
		
	if(isDragged):
		FrontPanel.z_index = 1000
		FrontPanel.global_position = get_global_mouse_position() - size / 2
	else:
		FrontPanel.z_index = 1
		FrontPanel.position = FrontPanel.position.lerp(Vector2.ZERO, delta * speed)

func _on_area_2d_mouse_entered():
	if(Globals.moneyManager.money >= GetCost()):
		Globals._SetSelectedDraggableHeroPanel(self)

func _on_area_2d_mouse_exited():
	Globals._SetSelectedDraggableHeroPanel(null)

func _generateRandomHero():
	#HeroType = Globals.unitManager._GetRandomUnupgradedType()
	HeroIcon = Globals.unitManager._GetRandomUnupgradedIcon()
	data = HeroIcon.data
	$Front_Panel/Price.text = str(data.cost)
	if(is_instance_valid(HeroIcon)):
		var TargetChild = FrontPanel.get_child(0)
		TargetChild.add_child(HeroIcon)
		HeroIcon.position = Vector2.ZERO + TargetChild.size / 2
		
	
	var randomHeroNum = RandomNumberGenerator.new().randf()
	#name = str(HeroType) + str(randomHeroNum)

func HandleUsed():
	mouse_filter =Control.MOUSE_FILTER_IGNORE
	Globals._SetDraggableAsNull()
	Globals._SetSelectedDraggableHeroPanel(null)
	
	set_process(false)
	if(is_instance_valid(FrontPanel)):
		FrontPanel.queue_free()

func HighLight(isOn):
	HighlightPanel.visible = isOn

func GetCost():
	return data.cost
