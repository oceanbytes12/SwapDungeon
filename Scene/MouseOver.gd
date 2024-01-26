extends Area2D

@export var mouse_over_text = "Replace Text"

# Add another export var for what image to change the cursor to?
#@export var image

func mouse_over():
	return mouse_over_text
