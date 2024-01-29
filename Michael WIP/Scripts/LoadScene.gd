extends Node


@export var scenename : String = ""

func _Start_Game():
	SceneLoader._ChangeToScene(scenename)
