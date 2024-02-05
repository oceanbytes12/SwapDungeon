extends State
class_name Slam

@export var own_body : CharacterBody2D
@export var anim : AnimationPlayer 
var aoeEffect = preload("res://Scenes/RandomEffects/AOE_Effect.tscn")
var aoe_location = Vector2(0, 20)
@export var radius = 60
@export var speed = 50
@export var damage = 50

func Enter(_target):
	print("Slam Done!")
	anim.play("SlamDown")

func SpawnAOE():
	var aoe = aoeEffect.instantiate()
	own_body.add_child(aoe)
	aoe.position = aoe_location

	aoe.initialize(radius, damage, speed)
	
	await get_tree().create_timer(1).timeout
	Transitioned.emit("Follow")
