extends Node


@export var scenename : String = ""

func _Start_Game():
	get_tree().change_scene_to_file(scenename)
