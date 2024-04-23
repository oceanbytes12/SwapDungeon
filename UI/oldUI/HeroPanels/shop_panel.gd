extends Control
class_name HeroRosterPanel

signal panel_chosen

var mouse_target = false
var hero_card : HeroCard
var index : int
var location : String

func set_hero_card(new_hero_card, new_index, new_location):
	location = new_location
	index = new_index
	hero_card = new_hero_card
	$Front_Panel/TextureRect.texture = hero_card.texture

func _input(event):
	if event.is_action_released("LeftClick") and mouse_target:
		$Front_Panel.visible = false
		panel_chosen.emit(index, location)

func _on_mouse_test_mouse_entered():
	scale = Vector2.ONE * 1.1
	mouse_target = true

func _on_mouse_test_mouse_exited():
	scale  = Vector2.ONE
	mouse_target = false
