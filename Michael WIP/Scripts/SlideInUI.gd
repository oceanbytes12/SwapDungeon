extends Control

var tween : Tween
signal on_tween_in_finish
signal on_tween_out_finish
var RotDuration : float = 0.2

@onready var Delay : float = randf_range(0.1,0.3)
@onready var MoveDuration : float = randf_range(0.1,0.3)
@onready var InitialX : float = position.x
@export var SlidingUI : Control
@export var Automatic : bool

func _ready():
	position.x = get_viewport_rect().size.x 
	if(Automatic):
		slide_in()
		
func slide_out():
	tween = create_tween()
	tween.tween_property(self, "position:x", get_viewport_rect().size.x, MoveDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	tween.tween_callback(inform_slide_in_finish)

func slide_in():
	tween = create_tween()
	tween.tween_property(self, "position:x", InitialX, MoveDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	tween.tween_callback(inform_slide_out_finish)
	
func inform_slide_in_finish():
	emit_signal("on_tween_in_finish")
	
func inform_slide_out_finish():
	emit_signal("on_tween_out_finish")
	
