extends CanvasLayer

@export var hero_cards : Array[HeroCard]
@export var shop_size : int = 3
@export var hero_panal_scene : PackedScene
var shop_cards : Array[HeroCard]
var roster_cards : Array[HeroCard]
var deployment_cards : Array[HeroCard]

func _ready():
	$Deployment.visible = false
	for i in shop_size:
		add_panel_to_shop(i)

func initialize_panel(new_hero_card, index, location):
	var new_hero_panel = hero_panal_scene.instantiate()
	new_hero_panel.set_hero_card(new_hero_card, index, location)
	new_hero_panel.panel_chosen.connect(on_panel_chosen)
	return new_hero_panel

func add_panel_to_shop(index):
	var random_index = randi_range(0, hero_cards.size())-1
	var new_hero_card = hero_cards[random_index]
	shop_cards.append(new_hero_card)
	var new_panel = initialize_panel(new_hero_card, index, "shop")
	$Shop/ShopDisplay.add_child(new_panel)

func add_roster_panel(new_hero_card):
	roster_cards.append(new_hero_card)
	var index = hero_cards.size()-1
	var new_panel = initialize_panel(new_hero_card, index, "roster")
	$Roster/Background/Roster.add_child(new_panel)

func add_deployment_panel(new_card):
	deployment_cards.append(new_card)
	var index = hero_cards.size()-1
	var new_panel = initialize_panel(new_card, index, "deployment")
	$Deployment/Grid/Space1.add_child(new_panel)
	
func on_panel_chosen(index, location):
	if location == "shop":
		$Shop.visible = false
		$Deployment.visible = true
		add_roster_panel(shop_cards[index])
	elif location == "roster":
		add_deployment_panel(roster_cards[index])

