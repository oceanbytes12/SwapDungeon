extends Object

var spawnPositions = []
var AlexTester
var unitManager
var Icons

static func _GetChildNodeOfType(parent, DesiredClass, allowInvisible = false):
	for child in parent.get_children():
		if is_instance_of(child, DesiredClass):
			if(allowInvisible or child.visible):
				return child

static func closest_target(targets: Array, global_position):  
	var closest = null  
	var shortest_distance: float = 10000.0  
	for target in targets:  
		var distance = global_position.distance_squared_to(target.position)  
		if  distance < shortest_distance:  
			shortest_distance = distance  
			closest= target  

static func farthest_target(targets: Array, global_position):  
	var furthest = null  
	var longest_distance: float = -10000.0  
	for target in targets:  
		var distance = global_position.distance_squared_to(target.position) 
		print(str(distance) + " is distance, and longest is: " + str(longest_distance))
		if  distance > longest_distance:  
			print("Happening!")
			longest_distance = distance  
			furthest= target  
	return furthest

#func _LoadPackedScenesInPath(path):
	#var ret = []
	#var dir = DirAccess.open(path) 
	#dir.open(path)
	#dir.list_dir_begin()
	#while true:
		#var file_name = dir.get_next()
		#if file_name == "":
			#break
		#elif file_name.contains(".tscn"):
			#if '.remap' in file_name: # <---- NEW
				#file_name = file_name.trim_suffix('.remap') # <---- NEW
			#var loaded_tscn = load(path + "/" + file_name)
			#ret.append(loaded_tscn)
			
	#dir.list_dir_end()
	#return ret
	
static func _ModulateChildren(node, newcolor):
	for child in node.get_children():
		if child is Sprite2D:
			# Modify the modulate property for each Sprite
			var sprite = child
			sprite.modulate = newcolor  # Set to red as an example
