extends Node2D

# UPDATE: This script and likely the nodes below it won't be in use
 
# Handle all special attacks performed by bosses.

@export var spawn_object = load("res://Scenes/DefaultWeapon/MeleeSkeleton.tscn")
@export var windup_time = 3
@export var AOE_damage = 10
@export var max_spawns_onscreen = 5

var spawn_positions = []
var is_winding_up = false

var targets_in_AOE_range = []
var bossRoot = null # This is a reference to the parent BaseBoss node
var SM = null # Reference to the state machine on the boss

var timeout_timer = 0
#@onready var testTarget = get_node("Archer1")

@onready var spawn_parent = $SpawnParent


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_positions = $SpawnPositions.get_children()
	bossRoot = get_parent()
	SM = bossRoot.get_node("SM")
	
	# For testing:

	#summon_spawn()
	#AOE_Attack()
	#print(testTarget)
	#windup("summon_spawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_winding_up:
		if timeout_timer > 0:
			timeout_timer -= delta
			
			if SM.current_target != null:
				# Rotate to follow direction of current target
				look_at(SM.current_target.global_position)
				#look_at(testTarget.current_target.global_position)
		else:
			# Call next attack
			is_winding_up = false
			pass
	
	
func Update(delta: float, _target: CharacterBody2D):
	print("update called")
	if timeout_timer > 0:
		timeout_timer -= delta
	else:
		pass

func AOE_Attack():
	#windup() ?
	#AttackAnimations.play("AOE_Attack")
	print("AOE_Attack() called")
	
	# Apply AOE damage to all targets in range
	for u in targets_in_AOE_range:
		print("calling take_hit on: ")
		print(u)
		u.take_hit(global_position, AOE_damage)


func summon_spawn():
	#windup() ?
	#AttackAnimations.play("SummonSpawn_Attack")
	
	# Note: The check for existing spawn should probably be called BEFORE selecting this attack
	# Check if there are aleady spawn in the game
	var existing_spawn_count = spawn_parent.get_child_count()
	if (existing_spawn_count < max_spawns_onscreen):
		# Note: Later this can be improved to randomize which spawn positions are chosen
	
		# Instantiate a spawn_object at each spawn_positions[]
		for pos in spawn_positions:
			var spawnObj = spawn_object.instantiate()
			spawn_parent.add_child(spawnObj)
			spawnObj.teamColor = "red"
			spawnObj.position = pos.position
			
			# Ensure we don't go over the max amount
			existing_spawn_count = existing_spawn_count + 1
			if (existing_spawn_count >= max_spawns_onscreen):
				#print("Max spawn count reached")
				break


	
#func windup(next attack fxn to call):
func windup(next_attack):
	print("windup called")
	# play windup animation for windup_time seconds?
	
	# Freeze boss movement for windup_time seconds.
	#Emit_to_SM("boss is performing special attack, stand still until done")
	
	# Start windup timer 
	is_winding_up = true
	timeout_timer = windup_time
	
	# Rotate in place to follow direction of selected target?
	# Display a flashing indicator ?
	#pass


# Not sure if these aoe enter/exit will work when added to main game
func _on_aoe_range_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print("_on_aoe_range_body_shape_entered() called")
	if body.is_in_group("unit") and body.teamColor != bossRoot.teamColor:
		targets_in_AOE_range.append(body)
		#print("Added unit to targets_in_AOE_range:")
		#print(body)

func _on_aoe_range_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	#print("_on_aoe_range_body_shape_exited() called")
	if body in targets_in_AOE_range:
		var arrayPos = targets_in_AOE_range.find(body)
		targets_in_AOE_range.remove_at(arrayPos)
		#print("Removed unit from targets_in_AOE_range:")
		#print(body)
