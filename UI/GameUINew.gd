extends CanvasLayer

@export var hero_cards : Array[HeroCard]
@export var shop_size : int = 3
@export var hero_panal_scene : PackedScene
var shop_display : Array[HeroCard]
var player_roster : Array[HeroCard]
var deployment : Array[HeroCard]

func _ready():
	$Deployment.visible = false
	for i in shop_size:
		add_panel_to_shop(i)

func add_panel_to_shop(index):
	var random_index = randi_range(0, hero_cards.size())-1
	var new_hero_card = hero_cards[random_index]
	var new_hero_panel = hero_panal_scene.instantiate()
	new_hero_panel.set_hero_card(new_hero_card, index)
	new_hero_panel.panel_chosen.connect(on_shop_panel_chosen)
	$Shop/ShopDisplay.add_child(new_hero_panel)
	shop_display.append(new_hero_card)

func add_panel_to_roster(new_hero_card):
	player_roster.append(new_hero_card)
	var new_hero_panel = hero_panal_scene.instantiate()
	var new_panel_index = hero_cards.size()
	new_hero_panel.set_hero_card(new_hero_card, new_panel_index)
	new_hero_panel.panel_chosen.connect(on_roster_panel_chosen)
	$Roster/Background/Roster.add_child(new_hero_panel)

func add_panel_to_deployment(new_hero_card):
	deployment.append(new_hero_card)
	var new_hero_panel = hero_panal_scene.instantiate()
	var new_panel_index = hero_cards.size()
	new_hero_panel.set_hero_card(new_hero_card, new_panel_index)
	new_hero_panel.panel_chosen.connect(on_roster_panel_chosen)
	$Roster/Background/Roster.add_child(new_hero_panel)

func on_shop_panel_chosen(index):
	$Shop.visible = false
	$Deployment.visible = true
	var chosen_hero_card = shop_display[index]
	add_panel_to_roster(chosen_hero_card)

func on_roster_panel_chosen(index):
	pass
	#var chosen_hero_card = player_roster[index]

