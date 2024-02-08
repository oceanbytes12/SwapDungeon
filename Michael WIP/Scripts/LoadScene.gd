extends Node


@export var gamescene : PackedScene

func _Start_Game():
	get_tree().change_scene_to_packed(gamescene)
	
