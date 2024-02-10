extends Marker2D

@export var attack_effect_scene : PackedScene
@export var own_body : CharacterBody2D
@export var attack_state : State
@export var damage : float
@export var knockback_amount : float
@export var cooldown : float

var target = null

func _ready():
	attack_state.Attacked.connect(_on_attack)
	attack_state.set_cooldown(cooldown)
	
func _process(_delta):
	if target:
		look_at(target.global_position)
	else:
		look_at(Vector2.RIGHT+global_position)
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x >= 0:
		scale.y = 1
	else:
		scale.y = -1

func _on_attack(target):
	if target:
		look_at(target.global_position)
	var attack_node = attack_effect_scene.instantiate()
	attack_node.global_position = $AttackPoint.global_position
	attack_node.rotation = rotation
	attack_node.damage = damage
	attack_node.knockback_amount = knockback_amount
	attack_node.own_body = own_body
	get_parent().get_parent().add_child(attack_node)
