extends Node2D

var money = 0
var unitIcons : Array
var Levels : Array

@export var HeroDataScenes : Array[PackedScene]
var HeroDatas : Array[HeroData]
var BasicHeroDatas : Array[HeroData]

@export var iconScene : PackedScene

var levelIndex = 0
@onready var loader = $Preloader

@export var use_context_cursors = true
#@export var mouse_pointer: Resource
@export var mouse_pointer = preload("res://Art/MousePointer1.png")
@export var mouse_grab = preload("res://Art/MousePointer2.png")
@export var mouse_open = preload("res://Art/MousePointer3.png")
@export var mouse_attack = preload("res://Art/MousePointer4.png")

func _GetNextLevel():
	if(levelIndex < Levels.size()):
		return Levels[levelIndex]

func _IncrementLevelIndex():
	levelIndex=levelIndex+1
	
#	print("Getting cost of: ", HeroType)
#	return CostDict[HeroType]

func _ready():
	Globals.unitManager = self
	
	Levels = loader.loadLevels()
	
	for dataScene in HeroDataScenes:
		var newData = dataScene.instantiate()
		$Data.add_child(newData)
		HeroDatas.append(newData)
		if("1" in newData.name):
			BasicHeroDatas.append(newData)
	

func _physics_process(_delta):
	if (use_context_cursors):
		var object = check_object_under_mouse()
		if object and object.teamColor == "red":
			Input.set_custom_mouse_cursor(mouse_attack, 0, Vector2(8,8))
		elif object and object.teamColor == "blue":
			Input.set_custom_mouse_cursor(mouse_pointer, 0, Vector2(8,8))
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			Input.set_custom_mouse_cursor(mouse_grab, 0, Vector2(8,8))
		else:
			Input.set_custom_mouse_cursor(mouse_open, 0, Vector2(8,8))

func check_object_under_mouse():
	var collider = check_collider_under_mouse()
	if(is_instance_valid(collider)):
		var clicked_unit = collider.get_parent() #Collider is Nil?
		if clicked_unit.is_in_group("unit") and collider.name == "ClickBox":
			return clicked_unit
	return null

func check_collider_under_mouse():
	# Get the mouse's position
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.position = get_global_mouse_position()
	# Check for collider
	var intersection = space.intersect_point(query,1)
	if intersection:
		return intersection[0].collider
	else:
		return null

#func _GetCost(HeroType):

#func _GetUnitInstanceOfType(HeroType):
#	return UnitDict[HeroType].instantiate()

#func _GetRandomUnupgradedType():
#	var randomIndex = randi() % UnupgradedDict.size()
#	return UnupgradedDict.keys()[randomIndex]

func GetIcon(data):
	var newIcon = iconScene.instantiate()
	newIcon.get_node("HeroSprite").texture = data.art
	return newIcon
	
func _GetRandomUnupgradedHero():
	var randomIndex = randi() % BasicHeroDatas.size()
	return BasicHeroDatas[randomIndex]
	
func findSubstringAfterLastSlashBeforeTscn(input_string: String) -> String:
	var regex_pattern := "/([^/]+)\\.tscn$"
	var regex := RegEx.new()
	
	if regex.compile(regex_pattern) != OK:
		return ""

	var match := regex.search(input_string)

	if match != null and match.get_strings().size() > 0:
		var substring_after_last_slash = match.get_string(1)
		return substring_after_last_slash
	else:
		return ""

func splitString(s):
	var classname = s.left(s.length() - 1)
	var classnum = s.right(s.length() - 1)
	return [classname, classnum]

func _GetUpgradedType(heroType):
	var nameandtype = splitString(heroType.unit.filename)
	var level = int(nameandtype[1])
	var name = nameandtype[0]
	level = level+1
	return name + str(level)

func _reset():
	get_tree().reload_current_scene()

func _quit():
	get_tree().quit()

