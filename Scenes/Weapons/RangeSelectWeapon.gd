extends Marker2D

@export var long_range_attack_effect_scene : PackedScene
@export var close_range_attack_effect_scene : PackedScene

@export var own_body : CharacterBody2D
@export var state_machine : Node
@export var attack_state : State
@export var approach_state: State
@export var long_range_damage : float
@export var close_range_damage : float
@export var knockback_amount : float
@export var cooldown : float
@export var weapon_range : float
@export var short_range_limit : float = 100

var target = null
var walk = Vector2.ZERO

func _ready():
	state_machine.newTarget.connect(_on_new_target)
	state_machine.newWalk.connect(_on_new_walk)
	attack_state.Attacked.connect(_on_attack)
	attack_state.set_cooldown(cooldown)
	attack_state.set_weapon_range(weapon_range)
	approach_state.set_weapon_range(weapon_range)
	
func _process(_delta):
	if is_instance_valid(target) or walk:
		var vector_to_target = Vector2.ZERO
		if walk:
			look_at(walk)
			vector_to_target = (walk - own_body.global_position).normalized()
		elif(is_instance_valid(target) and is_instance_valid(own_body)):
			look_at(target.global_position)
			vector_to_target = (target.global_position - own_body.global_position).normalized()
		var direction = Vector2.RIGHT.rotated(rotation)
		if direction.x >= 0:
			scale.y = 1
		else:
			scale.y = -1
		if vector_to_target.y >= -0.25:
			z_index = 1
		else:
			z_index = -1
	else:
		look_at(Vector2.RIGHT+global_position)

func _on_attack(_target):
	if(global_position.distance_to(target.global_position) > short_range_limit):
		long_range_attack()
	else:
		short_range_attack()
		
	
func short_range_attack():
	var attack_node = close_range_attack_effect_scene.instantiate()
	attack_node.set_transform_params($AttackPoint.global_position, rotation)
	attack_node.set_params(own_body, close_range_damage, knockback_amount, target)
	own_body.get_parent().add_child(attack_node)
		
func long_range_attack():
	var attack_node = long_range_attack_effect_scene.instantiate()
	attack_node.set_transform_params($AttackPoint.global_position, rotation)
	attack_node.set_params(own_body, long_range_damage, knockback_amount, target)
	own_body.get_parent().add_child(attack_node)
	
func _on_new_target(new_target):
	target = new_target

func _on_new_walk(new_walk):
	walk = new_walk