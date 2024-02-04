extends State
class_name MinotaurAOE

signal AOEAttack

@export var own_body : CharacterBody2D
@export var radius = 60
@export var speed = 50
@export var damage = 40

@export var aoeEffect = load("res://Scenes/RandomEffects/AOE_Effect.tscn")

# 
#@onready var source_pos = $SourcePosition

#Signal to start animation (move it from Follow?)
#Listen for Art2 signal "impact", Then release the effect
#in art2 on frame(4?) signal.emit()

func Enter(_target):
	print("MinotaurAOE entered")
	emit_signal("AOEAttack") #Can't play the animation(s) here, emit signal instead
	
func _on_art_2_start_aoe():
	print("Minotaur startAOE signal received")
	var aoe = aoeEffect.instantiate()
	add_child(aoe)
	#aoe.position = source_pos.global_position #old: own_body.position
	aoe.initialize(radius, damage, speed)
	aoe.position = $SourcePosition.position #old: own_body.position

func _on_art_2_aoe_anim_complete():
	# Why is this not getting called?
	print("aoe done called")
	#Transitioned.emit("Idle")
	#Transitioned.emit("Follow")
	Transitioned.emit("Cooldown")
	#return
