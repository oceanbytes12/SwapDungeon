extends State

class_name CDState

@export var cooldown : float
@export var cooldown_left : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown_left = clampf(cooldown_left-delta,0,cooldown)

func _reset_cooldown():
	cooldown_left = cooldown

func _is_cooling_down():
	return cooldown_left > 0
