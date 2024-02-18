extends Node2D

@export var HeroDatas:Array[PackedScene]
@export var CreatedDatas:Array[HeroData]
func _ready():
	for scene in HeroDatas:
		var data = scene.instantiate()
		add_child(data)
		CreatedDatas.append(data)

func _GetRandomHero():
	return HeroDatas.pick_random()
