class_name CameraShaker

var randomStrength = 30.0
var shakeFade = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength = 0.0
var target_node

#Could be good to implement the better version using noise
#Found here: https://gist.github.com/Alkaliii/3d6d920ec3302c0ce26b5ab89b417a4a

# Called when the node enters the scene tree for the first time.
func _init(target_node):
	
	#noise.octaves = 2
	#noise.fractal_gain = 2
	#noise.fractal_octaves = 2
	
	self.target_node = target_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _tick(delta):
	if randomStrength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade*delta)
		target_node.offset = randomOffset()
func _ready():
	randomize()
	

func add_trauma(amount):
	shake_strength = randomStrength

func randomOffset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
