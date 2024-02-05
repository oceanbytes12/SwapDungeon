extends State
class_name MinotaurAOE

signal AOEAttack

@export var own_body : CharacterBody2D
@export var radius = 60
@export var speed = 50
@export var damage = 40

@export var aoeEffect = load("res://Scenes/RandomEffects/AOE_Effect.tscn")


# Note: the 2D marker AOESourcePosition is not actually reference in code
var aoe_location = Vector2(-30, 22)


func Enter(_target):
	print("MinotaurAOE entered")
	emit_signal("AOEAttack") #Can't play the animation(s) here, emit signal instead
	#print(source_pos.global_position)


func _on_art_2_start_aoe():
	print("Minotaur startAOE signal received")
	var aoe = aoeEffect.instantiate()
	own_body.add_child(aoe)
	aoe.position = aoe_location
	aoe.initialize(radius, damage, speed)


func _on_art_2_aoe_anim_complete():
	# Why is this not getting called?
	print("aoe done called")
	#Transitioned.emit("Idle")
	#Transitioned.emit("Follow")
	Transitioned.emit("Cooldown")
	#return
