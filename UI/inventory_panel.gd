extends Control
class_name HeroRosterPanel

signal panel_chosen
@export var drag_panel : PackedScene

var mouse_target = false
var hero_card : HeroCard
var index : int
var location : String
var drag_timer: float = 0.0
var state : String = "shop"

var click_offset = Vector2(0, 0)
var origin_position = Vector2(0, 0)

func _process(delta):
	if state == "drag":
		global_position = get_global_mouse_position() - click_offset

func set_hero_card(new_hero_card, new_index, new_location):
	location = new_location
	index = new_index
	hero_card = new_hero_card
	$Front_Panel/TextureRect.texture = hero_card.texture

func _input(event):
	#if event.is_action_released("LeftClick") and mouse_target:
		#$Front_Panel.visible = false
		#panel_chosen.emit(index, location)
	if event.is_action_pressed("LeftClick") and mouse_target:
		state = "drag"
		origin_position = global_position
		click_offset = get_global_mouse_position() - global_position

	if event.is_action_released("LeftClick") and state == "drag":
		state = "shop"
		global_position = origin_position
		

func _on_front_box_mouse_entered():
	$Front_Panel.scale = Vector2.ONE * 1.1
	mouse_target = true


func _on_front_box_mouse_exited():
	$Front_Panel.scale  = Vector2.ONE
	mouse_target = false


func _on_back_box_mouse_entered():
	print("Entered")


func _on_back_box_mouse_exited():
	print("Exited")
