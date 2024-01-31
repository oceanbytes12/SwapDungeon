extends Control

var tween : Tween
signal on_tween_finish
var RotDuration : float = 0.2

@onready var Delay : float = randf_range(0.1,0.3)
@onready var Duration : float = 5
var InitialScale : float = 0.05
var FinalScale : float = 1


func _ready():
	expand_in()

func expand_in():
	scale = Vector2(InitialScale, InitialScale)
	tween = create_tween() # Creates a new tween
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 0.25)
	#tween.interpolate_property($Box, "scale", Vector2(1, 1), Vector2(2, 2), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	#tween.interpolate_value($Box, "scale", Vector2(FinalScale,FinalScale), Duration)
	#tween.tween_property(self, "position:x", InitialX+5, MoveDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	#tween.chain().tween_property(SlidingImage, "rotation_degrees", 0, RotDuration).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_callback(inform_finish)
	
func inform_finish():
	emit_signal("on_tween_finish")
	
