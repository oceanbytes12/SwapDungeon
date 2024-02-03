extends State
class_name SummonUnits

@export var own_body: CharacterBody2D
@export var body_art : Sprite2D
@export var spawn_object: Resource

func summon_spawn(target):
	await get_tree().create_timer(10).timeout
	# Instantiate a spawn_object at each spawn_positions[]
	var Offsets = [Vector2.UP, Vector2.DOWN]
	Offsets.shuffle()
	
	for index in 2:
		print("Spawning a dude!")
		var spawnPosition = own_body.position + Offsets[0] * 50
		Offsets.remove_at(0)
		if (body_art.flip_h):
			spawnPosition = spawnPosition + Vector2.RIGHT * 20 
		else:
			spawnPosition = spawnPosition + Vector2.LEFT * 20 
	
		var spawnObj = spawn_object.instantiate()
		own_body.get_parent().add_child(spawnObj)
		spawnObj.teamColor = "red"
		spawnObj.position = spawnPosition
		spawnObj.set_target(target)
		spawnObj.runSpeed = spawnObj.runSpeed / 2
				
func Enter(target):
	summon_spawn(target)
	await get_tree().create_timer(4).timeout
	Transitioned.emit("Attack")
