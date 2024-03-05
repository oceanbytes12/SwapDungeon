extends Control

@export var shop_size : int = 3
@export var hero_list : Array[PackedScene]
@export var hero_panal_scene : PackedScene
@export var drag_panel_scene : PackedScene

#@export var NewHero : PackedScene

func _ready():
	roll_new_heros()
	
func roll_new_heros():
	for i in shop_size:
		var random_index = randi_range(0, hero_list.size())
		var new_hero_panel = hero_panal_scene.instantiate()
		new_hero_panel.panel_chosen.connect(on_panel_chosen)
		$ShopIconDisplay.add_child(new_hero_panel)

func on_panel_chosen(panel):
	var new_hero_panel = hero_panal_scene.instantiate()
	
	#var new_drag_panel = drag_panel_scene.instantiate()
	#get_parent().add_child(new_drag_panel)