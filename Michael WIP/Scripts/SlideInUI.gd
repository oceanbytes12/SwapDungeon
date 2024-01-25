extends Control

var tween : Tween
signal on_tween_finish
var RotDuration : float = 0.2

@onready var Delay : float = randf_range(0.1,0.3)
@onready var MoveDuration : float = randf_range(0.1,0.3)
@onready var InitialX : float = position.x
@onready var SlidingImage : TextureRect = $SlidingImage

func _ready():
	position.x = get_viewport_rect().size.x 
	SlidingImage.rotation_degrees = 20
	rotation
	slide_in()

func slide_in():
	tween = create_tween() # Creates a new tween
	tween.tween_property(self, "position:x", InitialX+5, MoveDuration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT).set_delay(Delay)
	tween.chain().tween_property(SlidingImage, "rotation_degrees", 0, RotDuration).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(inform_finish)
	
func inform_finish():
	emit_signal("on_tween_finish")
	
