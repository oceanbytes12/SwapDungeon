extends Node

@onready var PartyParent = $Party
@export var PartyBattleUI : Control
@export var battlePanels : Array[UIBattleSpace]
@export var StartBattleButton : TextureButton
@export var GameScript : Node2D
@export var tileMap : TileMap

var battleParent
var isBattling

signal move_To_Ready_Screen

signal finish_battle
signal lose_battle
signal finish_game

func _GetHeroTypesFromBattleUIPanels():
	var ret = []
	for heroPanel in battlePanels:
		if(heroPanel.GetHeroType()):
			ret.append(heroPanel.GetHeroType())
		else:
			ret.append(null)
	return ret

func _BattlePartyGreaterThanOne():
	for heroPanel in battlePanels:
		if(heroPanel.GetHeroType() != null):
			return true
	return false

func _StartBattle():
	Globals.ResetUI()
	if(is_instance_valid(battleParent)):
		battleParent._Toggle(true)
		
	#tileMap.visible = false
	isBattling = true
	#battleParent = GameScript._GetNextLevel().instantiate()
	call_deferred("_SpawnHeros")
	
func _SpawnHeros():
	var spawns = Globals.spawnPositions
	var heros = _GetHeroTypesFromBattleUIPanels()
	for heroEnumIndex in heros.size():
		var currentEnum = heros[heroEnumIndex]
		
		if(!currentEnum):
			continue
		
		#Swap this out for a reference to a real hero!
		#res://Scenes/Units/
		
		var newHero = GameScript._GetUnitInstanceOfType(currentEnum)
		if(is_instance_valid(newHero)):
			newHero.controllable = true
			#Position them properly
			battleParent.add_child(newHero)
			newHero.global_position = spawns[heroEnumIndex].global_position
		else:
			print("No new hero made for: " + str(currentEnum))
func _FinishPartyAddition():
	tileMap.visible = false
	battleParent = GameScript._GetNextLevel().instantiate()
	get_parent().get_parent().add_child(battleParent)
	if(is_instance_valid(battleParent)):
		battleParent._Toggle(false)
	emit_signal("move_To_Ready_Screen")

func _UnLoadHeros():
	for n in PartyParent.get_children():
		PartyParent.remove_child(n)
		n.queue_free()

func _process(_delta):
	if(isBattling):
		if(EnemiesAreDead()):
			_WinBattle()
		elif(PlayersAreDead()):
			_LoseBattle()
	else:
		StartBattleButton.visible = (_BattlePartyGreaterThanOne())
			
func _WinBattle():
	isBattling = false
	await get_tree().create_timer(1).timeout
	battleParent.queue_free()
	Globals.spawnPositions.clear()
	Globals.moneyManager.GainMoney(10)
	GameScript._IncrementLevelIndex()
	if(GameScript._GetNextLevel()):
		emit_signal("finish_battle")
		tileMap.visible = true
	else:
		emit_signal("finish_game")
	
func _LoseBattle():
	isBattling = false
	await get_tree().create_timer(1).timeout
	battleParent.queue_free()
	Globals.spawnPositions.clear()
	emit_signal("lose_battle")

func _kill_all_enemies():
	if(is_instance_valid(Globals.CurrentUnitController)):
		Globals.CurrentUnitController._kill_all_enemies()

func _kill_all_players():
	if(is_instance_valid(Globals.CurrentUnitController)):
		Globals.CurrentUnitController._kill_all_players()

func EnemiesAreDead():
	if(is_instance_valid(Globals.CurrentUnitController)):
		return Globals.CurrentUnitController.EnemiesAreDead()
	return false

func PlayersAreDead():
	if(is_instance_valid(Globals.CurrentUnitController)):
		return Globals.CurrentUnitController.PlayersAreDead()
	return false

