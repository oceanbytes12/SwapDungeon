extends Node


@export var spawnPositions: Array[Node2D]
@export var partyPanels: Array[HeroUIPanel]
@onready var PartyParent = $Party
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
	var heros = _GrabHerosFromUI()
	for heroEnumIndex in heros.size():
		var currentEnum = heros[heroEnumIndex]
		
		if(!currentEnum):
			continue
		
		var newHero = Globals._GetIconInstanceOfType(currentEnum)
		newHero.z_index = -1000
		PartyParent.add_child(newHero)
		newHero.global_position = spawnPositions[heroEnumIndex].global_position
		print("Spawning Hero at: ", newHero.global_position)

func _FinishPartyAddition():
	print("Finishing Addition")
	emit_signal("move_To_Ready_Screen")
