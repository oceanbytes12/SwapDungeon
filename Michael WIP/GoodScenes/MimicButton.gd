extends TextureButton


func _on_toggled():
	$UI_button.post_event()
	$Mimic_close.post_event()


func _on_mouse_entered():
	#$Mimic_open.post_event()
	
func _on_mouse_exited():
	#$Mimic_shut.post_event()
