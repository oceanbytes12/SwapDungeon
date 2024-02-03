extends CharacterBody2D

@export var teamColor : String
@export var controllable: bool
@export var walkSpeed: float
@export var runSpeed: float

@export var meleeRange: float = 20
@export var AOERange: float = 30
@export var chargeRange: float = 80
@export var boulderRange: float = 120

@export var attackCooldown: float
@export var standardDamage: int
#@export var MeleeDamage: int
@export var AOEDamage: int
@export var chargeDamage: int

signal Hit
signal WalkCommand
signal AttackCommand 
#signal AOEAttackCommand
#signal SpecialAttackCommand # Such as Charge, Bite
signal Died

var selected = false
var targeted = false
var is_dead = false
@onready var state_machine = $SM

func set_selected(value):
	if controllable:
		selected = value
		$Selection.visible = value
	else:
		$Selection.visible = false

func set_targeted(value):
	if not controllable and not is_dead:
		targeted = value
		$Targeted.visible = value
	else:
		$Targeted.visible = false

func _ready():
	set_selected(selected)
	set_targeted(targeted)
	#if teamColor == "blue":
		#$Art/BlueHat.visible = true
		#$Art/RedHat.visible = false
	#elif teamColor == "red":
		#$Art/BlueHat.visible = false
		#$Art/RedHat.visible = true


func _process(_delta):
	if velocity.length() < 1 and not is_dead:
		$MovementAnimations.play("RESET")
	elif velocity.length() < walkSpeed + 1 and not is_dead:
		$MovementAnimations.play("Walk")
	elif velocity.length() > walkSpeed and not is_dead:
		$MovementAnimations.play("WalkFast")
	#if velocity.length() <= walkSpeed and velocity.length() > 8:
		#$MovementAnimations.play("Walk")
	#elif velocity.length() > walkSpeed:
		#$MovementAnimations.play("WalkFast")
	if velocity.x < 0:
		$Art/Body.flip_h = true
		$Art/Head.flip_h = true
	elif velocity.x > 0:
		$Art/Body.flip_h = false
		$Art/Head.flip_h = false

func _physics_process(_delta):
	move_and_slide()

func set_walk():
	WalkCommand.emit(get_global_mouse_position())
	
func set_target(target):
	AttackCommand.emit(target)

func take_hit(hit_position, damage):
	$UI/HealthBar.value -= damage
	if $UI/HealthBar.value <= 0:
		is_dead = true
		$UI/HealthBar.visible = false
		$CollisionShape2D.queue_free()
		$Art/BlueHat.visible = false
		$Art/RedHat.visible = false
		$Selection.visible = false
		$Targeted.visible = false
		Died.emit()
		z_index = 0
		$MovementAnimations.play("Die")
		$Art/DeadHead.visible = true
		$Art/Head.visible = false
		targeted = false
		selected = false
		controllable = false

	else:
		var direction = (global_position-hit_position).normalized()
		Hit.emit(direction)
		$EffectAnimations.play("hitAnimation")

func Die():
	is_dead = true
	$UI/HealthBar.visible = false
	if(is_instance_valid($CollisionShape2D)):
		$CollisionShape2D.queue_free()
	$Art/BlueHat.visible = false
	$Art/RedHat.visible = false
	Died.emit()
	$MovementAnimations.play("Die")
