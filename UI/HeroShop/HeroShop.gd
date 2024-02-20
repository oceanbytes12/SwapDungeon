extends Control

@export var parent : Control
@export var numToGenerate : int
@export var NewHero : PackedScene
#@onready var NewHero = preload("res://Michael WIP/GoodScenes/AddableHero.tscn")

func Generate():
	for i in numToGenerate:
		var newHeroNode = NewHero.instantiate()
		newHeroNode.call_deferred("_generateRandomHero")
		parent.add_child(newHeroNode)

func Demolish():
	for n in parent.get_children():
		parent.remove_child(n)
		n.queue_free() 

