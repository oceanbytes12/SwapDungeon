extends Node

@onready var level = preload("res://Scene/Levels/Level1.tscn")
@onready var PartyParent = $Party
@onready var MeleeSkeleton = preload("res://Scenes/Meleer.tscn")
@export var PartyBattleUI : Control
@export var partyPanels : Array[HeroUIPanel] 
@export var battlePanels : Array[UIBattleSpace]
var battleParent
var isBattling
signal move_To_Ready_Screen
signal finish_battle
signal lose_battle

func _GetHeroTypesFromBattleUIPanels():
	var ret = []
	for heroPanel in battlePanels:
		if(heroPanel.GetHeroType()):
			ret.append(heroPanel.GetHeroType())
		else:
			ret.append(null)
	return ret

func _StartBattle():
	isBattling = true
	
	battleParent = level.instantiate()
	call_deferred("_SpawnHeros")
	get_parent().get_parent().add_child(battleParent)
	
func _SpawnHeros():
	var spawns = Globals.spawnPositions
	var heros = _GetHeroTypesFromBattleUIPanels()
	for heroEnumIndex in heros.size():
		var currentEnum = heros[heroEnumIndex]
		
		if(!currentEnum):
			continue
		
		#Swap this out for a reference to a real hero!
		var newHero = MeleeSkeleton.instantiate()
		newHero.teamColor = "blue"
		newHero.controllable = true
		#Position them properly
		battleParent.add_child(newHero)
		newHero.global_position = spawns[heroEnumIndex].global_position
		print("Spawning Hero at: ", newHero.global_position)

func _FinishPartyAddition():
	#print("Finishing Addition")
	emit_signal("move_To_Ready_Screen")

func _UnLoadHeros():
	for n in PartyParent.get_children():
		PartyParent.remove_child(n)
		n.queue_free()

func _process(delta):
	if Input.is_key_pressed(KEY_K):
		_kill_all_enemies()
	
	if Input.is_key_pressed(KEY_L):
		_kill_all_players()
	
	if(isBattling):
		if(EnemiesAreDead()):
			_WinBattle()
		elif(PlayersAreDead()):
			_LoseBattle()

func _WinBattle():
	isBattling = false
	await get_tree().create_timer(1).timeout
	battleParent.queue_free()
	Globals.spawnPositions.clear()
	emit_signal("finish_battle")
	
func _LoseBattle():
	isBattling = false
	await get_tree().create_timer(1).timeout
	battleParent.queue_free()
	Globals.spawnPositions.clear()
	emit_signal("lose_battle")

func _kill_all_enemies():
	if(is_instance_valid(Globals.AlexTester)):
		Globals.AlexTester._kill_all_enemies()

func _kill_all_players():
	if(is_instance_valid(Globals.AlexTester)):
		Globals.AlexTester._kill_all_players()

func EnemiesAreDead():
	if(is_instance_valid(Globals.AlexTester)):
		return Globals.AlexTester.EnemiesAreDead()
	return false

func PlayersAreDead():
	if(is_instance_valid(Globals.AlexTester)):
		return Globals.AlexTester.PlayersAreDead()
	return false

