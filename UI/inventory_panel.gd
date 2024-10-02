extends Control
class_name HeroRosterPanel

signal panel_chosen
@export var drag_panel : PackedScene

var mouse_target = false
var hero_card : HeroCard
var index : int
var location : String
var drag_timer: float = 0.0

func set_hero_card(new_hero_card, new_index, new_location):
	location = new_location
	index = new_index
	hero_card = new_hero_card
	$Front_Panel/TextureRect.texture = hero_card.texture

func _input(event):
	if event.is_action_released("LeftClick") and mouse_target:
		$Front_Panel.visible = false
		panel_chosen.emit(index, location)
	elif event.is_action_pressed("LeftClick") and mouse_target:
		$Front_Panel.visible = false
		var new_panel = drag_panel.instantiate()
		new_panel.click_offset = get_global_mouse_position() - global_position
		get_parent().get_parent().add_child(new_panel)
		

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
