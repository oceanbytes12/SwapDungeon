extends Control

signal mouse_entered_roster
signal mouse_exited_roster

func _on_texture_rect_mouse_entered():
	mouse_entered_roster.emit()


func _on_texture_rect_mouse_exited():
	mouse_exited_roster.emit()


func add_panel(panel):
	$RosterUI/MarginContainer/Roster.add_child(panel)
