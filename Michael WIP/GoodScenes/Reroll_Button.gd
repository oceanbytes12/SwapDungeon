extends Button





func _on_pressed():
	$UI_button.post_event()
	$Reroll.post_event()
