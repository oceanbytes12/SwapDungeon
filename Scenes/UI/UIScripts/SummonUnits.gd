extends State
class_name SummonUnits

@export var own_body: CharacterBody2D
@export var spawn_object : PackedScene
@export var nextState : String
@export var num_summoned : int 
@export var summon_increment_amount : int
@export var state_duration : float
var current_state_duration

func summon_spawn(target, summoner):
	if(!is_instance_valid(target)):
		return
		
	await get_tree().create_timer(0.5).timeout
	# Instantiate a spawn_object at each spawn_positions[]
	var desiredSummonPoint = own_body.position.lerp(target.position ,0.5)
	var points = generate_evenly_distributed_points_in_circle(20, num_summoned)
	for index in num_summoned:
		var spawnPosition = desiredSummonPoint + points[index]

		#var spawnPosition = target.position + VertOffsets[0] * 20 
		#VertOffsets.remove_at(0)
		var spawnObj = spawn_object.instantiate()
		own_body.get_parent().add_child(spawnObj)
		spawnObj.type = summoner.type
		spawnObj.position = spawnPosition
		spawnObj.set_target(target)
		spawnObj.move_speed = spawnObj.move_speed / 2
		
	num_summoned = num_summoned + summon_increment_amount
				
func Update(_delta, own_body, current_target, target_list, walk_target):
	current_state_duration -= _delta
	if(current_state_duration <= 0):
		ChangeState.emit(nextState, current_target, walk_target)
	
func Enter(_own_body, _current_target, _target_list):
	summon_spawn(_current_target, _own_body)
	current_state_duration = state_duration
	
func generate_evenly_distributed_points_in_circle(radius, num_points):
	var points = []
	var golden_angle = PI * (3 - sqrt(5))

	for i in range(num_points):
		var theta = i * golden_angle
		var r = sqrt(randf()) * radius
		var x = r * cos(theta)
		var y = r * sin(theta)
		points.append(Vector2(x, y))

	return points
