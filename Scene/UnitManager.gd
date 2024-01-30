extends Node

class_name UnitManager

var unitFolder = "res://Scenes/Units/Players/"
var UnitDict = {}
var UnupgradedDict = {}



func _ready():
	Globals.unitManager = self
	for unit in Globals._LoadPackedScenesInPath(unitFolder):
		var unitname = findSubstringAfterLastSlashBeforeTscn(unit.resource_path)
		UnitDict[unitname] = unit
		if("1" in unitname):
			UnupgradedDict[unitname] = unit
			
func _GetUnitInstanceOfType(HeroType):
	return UnitDict[HeroType].instantiate()

func _GetOnlyUnupgradedUnits():
	var ret = {}
	for unit in UnitDict.keys():
		if "1" in unit:
			ret[unit] = UnitDict[unit]

func _GetRandomUnupgradedType():
	var randomIndex = randi() % UnupgradedDict.size()
	return UnupgradedDict.keys()[randomIndex]

func findSubstringAfterLastSlashBeforeTscn(input_string: String) -> String:
	var regex_pattern := "/([^/]+)\\.tscn$"
	var regex := RegEx.new()
	
	if regex.compile(regex_pattern) != OK:
		print("Error compiling regex pattern")
		return ""

	var match := regex.search(input_string)

	if match != null and match.get_strings().size() > 0:
		var substring_after_last_slash = match.get_string(1)
		return substring_after_last_slash
	else:
		print("No match found")
		return ""

func splitString(s):
	var classname = s.left(s.length() - 1)
	var classnum = s.right(s.length() - 1)
	return [classname, classnum]

func _GetUpgradedType(heroType):
	var nameandtype = splitString(heroType)
	var level = int(nameandtype[1])
	var name = nameandtype[0]
	level = level+1
	return name + str(level)
