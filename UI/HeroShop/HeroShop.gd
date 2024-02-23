extends Control

@export var shop_size : int = 3
@export var hero_list : Array[PackedScene]
@export var hero_panal_scene : PackedScene
@export var PartyRoster : Control
@export var drag_panel_scene : PackedScene
#@export var NewHero : PackedScene

func _ready():
	roll_new_heros()
	PartyRoster.mouse_entered_roster.connect(mouse_on_roster)
	PartyRoster.mouse_exited_roster.connect(mouse_off_roster)
	

func roll_new_heros():
	for i in shop_size:
		var random_index = randi_range(0, hero_list.size())
		#var new_hero_icon = hero_list[random_index]
		var new_hero_panel = hero_panal_scene.instantiate()
		new_hero_panel.panel_chosen.connect(on_panel_chosen)
		$ShopIconDisplay.add_child(new_hero_panel)

func on_panel_chosen(panel):
	var new_hero_panel = hero_panal_scene.instantiate()
	PartyRoster.add_panel(new_hero_panel)
	
	#var new_drag_panel = drag_panel_scene.instantiate()
	#get_parent().add_child(new_drag_panel)


func mouse_on_roster():
	print("entered")


func mouse_off_roster():
	print("exited")

