extends Area2D

@export var spawnedMagic : PackedScene
@export var numberToSpawn : float
@export var interval : float
@onready var currentInterval = interval

var own_body
var target
var source_type
var damage 
var knockback_amount
#attack_node.set_params(own_body, damage, knockback_amount, target)

func set_transform_params(global_position, rotation):
	self.global_position = global_position

func set_params(new_own_body, new_damage, new_knockback_amount, target=null):
	self.target = target
	self.own_body = new_own_body
	self.damage = new_damage
	self.knockback_amount = new_knockback_amount
	self.source_type = self.own_body.type

func _ready():
	$AnimatedSprite2D.play("Spell")
	$Necro_multicast_sfx.play()
	$Portal_sfx.play()

func _process(delta):
	currentInterval-=delta
	if(currentInterval <= 0):
		currentInterval = 0
		#print("Spawning Magic Attack")
		currentInterval = interval
		numberToSpawn=numberToSpawn-1
		var attackNode = spawnedMagic.instantiate()
		var randomX = -randi()%30
		var randomY = -randi()%30
		var randomOff = Vector2(randomX,randomY)
		attackNode.global_position = $AttackPoint.global_position + randomOff
		var randomPositionOffset = randf_range(-10.0, 10.0) * Vector2.ONE
		if(is_instance_valid(target)):
			attackNode.look_at(target.position + randomPositionOffset)
			attackNode.target = target
			
		attackNode.source_type = source_type
		attackNode.source_body = own_body
		attackNode.knockback_amount = knockback_amount
		
		get_parent().get_parent().add_child(attackNode)
		
		if(numberToSpawn <= 0):
			queue_free()
