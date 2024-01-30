extends Node

var spawnPositions = []
var AlexTester

func _GetChildNodeOfType(parent, DesiredClass, allowInvisible = false):
	var desired_children = []
	for child in parent.get_children():
		if is_instance_of(child, DesiredClass):
			if(allowInvisible or child.visible):
				return child

func _LoadPackedScenesInPath(path):
	var ret = []
	var dir = DirAccess.open(path) 
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif file_name.ends_with(".tscn"):
			ret.append(load(path + "/" + file_name))
	dir.list_dir_end()
	return ret
	
