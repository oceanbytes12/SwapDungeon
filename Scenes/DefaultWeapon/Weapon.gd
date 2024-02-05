extends Marker2D

@export var weaponEffectScene : PackedScene
@export var own_body : CharacterBody2D
@export var attackState : State
@export var spawnUsesRotation : bool = true
@export var spawnUsesPosition : bool = true
@export var knockBackOverride := 50
var damageOverride

var target
func _ready():
	attackState.Attacked.connect(_on_attack_attacked)
	attackState.Targetted.connect(_on_target)
	attackState.Untarget.connect(_on_untarget)
	own_body.Died.connect(_on_body_died)
	damageOverride = own_body.weaponDamage
	
func _process(_delta):
	if target:
		look_at(target.global_position)
	elif own_body.velocity.x >= 0:
		look_at(Vector2.RIGHT+global_position)
	else:
		look_at(Vector2.LEFT+global_position)
	var direction = Vector2.RIGHT.rotated(rotation)
	if direction.x >= 0:
		scale.y = 1
	else:
		scale.y = -1

func _on_attack_attacked():
	if target:
		look_at(target.global_position)
	var attackNode = weaponEffectScene.instantiate()
	if(spawnUsesPosition):
		attackNode.global_position = $AttackPoint.global_position
	
	if(spawnUsesRotation):
		attackNode.rotation = rotation
		
	attackNode.source_team_color = own_body.teamColor
	attackNode.target = target
	attackNode.damage = damageOverride
	if attackNode.has_method("set_knockback"):
		attackNode.set_knockback(knockBackOverride)
	get_parent().get_parent().add_child(attackNode)


func _on_target(t):
	target = t

func _on_body_died():
	$Art.visible = false

func _on_untarget():
	target = null
