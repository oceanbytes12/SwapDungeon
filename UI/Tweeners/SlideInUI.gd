extends Control

var tween : Tween
signal on_tween_in_start
signal on_tween_out_finish
var RotDuration : float = 0.2

@onready var Delay : float = randf_range(0.1,0.3)
@onready var MoveDuration : float = 0.3
@onready var outDuration : float = 0.05
@onready var InitialX : float = position.x
@export var SlidingUI : Control
@export var Automatic : bool

func _ready():
	position.x = get_viewport_rect().size.x + 100
	if(Automatic):
		slide_in()
		
func slide_out():
	tween = create_tween()
	tween.tween_property(self, "position:x", get_viewport_rect().size.x, outDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	tween.tween_callback(finish_slide_out)

func finish_slide_out():
	emit_signal("on_tween_out_finish")

func slide_in():
	visible = true
	
	emit_signal("on_tween_in_start")
	
	tween = create_tween()
	tween.tween_property(self, "position:x", InitialX, MoveDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)

func slide_out_then_in():
	tween = create_tween()
	tween.tween_property(self, "position:x", get_viewport_rect().size.x, outDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	tween.tween_callback(finish_slide_out)
	
	tween.tween_callback(slide_in)
