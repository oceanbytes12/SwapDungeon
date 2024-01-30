extends Node

var spawnPositions = []
var AlexTester
var unitManager

func _GetChildNodeOfType(parent, DesiredClass, allowInvisible = false):
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
	
func _ModulateChildren(node, newcolor):
	for child in node.get_children():
		print("Attempting Modulating!")
		if child is Sprite2D:

			# Modify the modulate property for each Sprite
			var sprite = child
			sprite.modulate = newcolor  # Set to red as an example
