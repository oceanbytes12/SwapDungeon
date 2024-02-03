extends State
class_name MinotaurAOE

signal AOEAttack

@export var own_body : CharacterBody2D
@export var radius = 60
@export var speed = 50
@export var damage = 40

@export var aoeEffect = load("res://Scenes/RandomEffects/AOE_Effect.tscn")


func Enter(_target):
	print("MinotaurAOE entered")
	emit_signal("AOEAttack") #Can't play the animation(s) here, emit signal instead
	
	var aoe = aoeEffect.instantiate()
	add_child(aoe)
	aoe.position = own_body.position
	aoe.initialize(radius, damage, speed)
	
	return
