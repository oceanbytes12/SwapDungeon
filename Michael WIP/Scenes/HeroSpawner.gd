extends Node


@export var spawnPositions: Array[Node2D]
@export var partyPanels: Array[HeroUIPanel]
@onready var PartyParent = $Party
@onready var level = preload("res://Scene/Level1.tscn")
@onready var MeleeSkeleton = preload("res://Scenes/Meleer.tscn")
signal move_To_Ready_Screen

func _GrabHerosFromUI():
	var ret = []
	for heroPanel in partyPanels:
		if(heroPanel.GetHeldHero()):
			ret.append(heroPanel.GetHeldHero().HeroType)
		else:
			ret.append(null)
	return ret

func _LoadHeros():
	var newNode = level.instantiate()
	var heros = _GrabHerosFromUI()
	for heroEnumIndex in heros.size():
		var currentEnum = heros[heroEnumIndex]
		
		if(!currentEnum):
			continue
		
		#Swap this out for a reference to a real hero!
		var newHero = MeleeSkeleton.instantiate()
		newHero.teamColor = "blue"
		newHero.controllable = true
		#Position them properly
		newNode.add_child(newHero)
		newHero.global_position = spawnPositions[heroEnumIndex].global_position
		print("Spawning Hero at: ", newHero.global_position)
	
	get_parent().get_parent().add_child(newNode)

func _FinishPartyAddition():
	print("Finishing Addition")
	emit_signal("move_To_Ready_Screen")

func _UnLoadHeros():
	for n in PartyParent.get_children():
		PartyParent.remove_child(n)
		n.queue_free()
