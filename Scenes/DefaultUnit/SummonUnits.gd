extends State
class_name SummonUnits

@export var own_body: CharacterBody2D
@export var body_art : Sprite2D
@export var spawn_object: Resource
@export var nextState : String
@export var num_summoned : int 
@export var increment_amount_post_summon : int
func summon_spawn(target):
	if(!is_instance_valid(target)):
		return
		
	await get_tree().create_timer(1).timeout
	# Instantiate a spawn_object at each spawn_positions[]
	var desiredSummonPoint = own_body.position.lerp(target.position ,0.5)
	var points = generate_evenly_distributed_points_in_circle(20, num_summoned)
	for index in num_summoned:
		print("Summoning a dude2!")
		var spawnPosition = desiredSummonPoint + points[index]

		#var spawnPosition = target.position + VertOffsets[0] * 20 
		#VertOffsets.remove_at(0)
		var spawnObj = spawn_object.instantiate()
		own_body.get_parent().add_child(spawnObj)
		spawnObj.teamColor = "red"
		spawnObj.position = spawnPosition
		spawnObj.set_target(target)
		spawnObj.runSpeed = spawnObj.runSpeed / 2
		
	num_summoned = num_summoned + increment_amount_post_summon
				
func Enter(target):
	summon_spawn(target)
	await get_tree().create_timer(2).timeout
	Transitioned.emit(nextState)


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
