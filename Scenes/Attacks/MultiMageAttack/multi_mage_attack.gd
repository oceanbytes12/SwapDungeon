extends Area2D

@export var spawnedMagic : PackedScene
@export var numberToSpawn : float
@export var interval : float
@onready var currentInterval = interval

var target
var source_team_color
var damage = 40

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
			
		attackNode.source_team_color = source_team_color
		get_parent().get_parent().add_child(attackNode)
		
		if(numberToSpawn <= 0):
			queue_free()
