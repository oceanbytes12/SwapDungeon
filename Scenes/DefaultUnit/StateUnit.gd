extends CharacterBody2D

@export var teamColor : String
@export var controllable: bool
@export var support_unit := false
@export var can_be_stunned = true
@export var walkSpeed: float
@export var runSpeed: float
@export var weaponRange: float
@export var weaponCooldown: float
@export var weaponDamage: int
@export var unitHealth: float
@export var skeleton_die_scene : PackedScene

signal Hit
signal WalkCommand
signal AttackCommand
signal Died

var selected = false
var targeted = false
var is_dead = false

@onready var hitEffect = preload("res://Scenes/RandomEffects/HitEffect.tscn")
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
	$UI/HealthBar.max_value = unitHealth
	$UI/HealthBar.value = unitHealth
	set_selected(selected)
	set_targeted(targeted)

func _process(_delta):
	# Quick fix to add back unit animations without affecting bosses
	if can_be_stunned:
		if velocity.length() < 1 and not is_dead:
			$MovementAnimations.play("RESET")
		elif velocity.length() < walkSpeed + 1 and not is_dead:
			$MovementAnimations.play("Walk")
		elif velocity.length() > walkSpeed and not is_dead:
			$MovementAnimations.play("WalkFast")
	if $SM.current_target:
		var target_vector = $SM.current_target.global_position - global_position
		if target_vector.x < 0:
			$Art/Body.flip_h = true
			$Art/Head.flip_h = true
		elif target_vector.x > 0:
			$Art/Body.flip_h = false
			$Art/Head.flip_h = false

func _physics_process(_delta):
	move_and_slide()

func set_walk():
	WalkCommand.emit(get_global_mouse_position())
	
func set_target(target):
	AttackCommand.emit(target)

func take_hit(hit_position, damage, hitstun=50):
	$UI/HealthBar.value -= damage
	if damage >= 0:
		var newNode = hitEffect.instantiate()
		newNode.global_position = global_position
		newNode.set_damage_text(damage)
		get_parent().get_parent().add_child(newNode)
	else:
		var newNode = hitEffect.instantiate()
		newNode.global_position = global_position
		newNode.set_damage_text(damage*-1)
		get_parent().get_parent().add_child(newNode)
	if $UI/HealthBar.value <= 0:
		is_dead = true
		$UI/HealthBar.visible = false
		$CollisionShape2D.queue_free()
		#$Art/BlueHat.visible = false
		#$Art/RedHat.visible = false
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
		print("StateUnit getting hit: ", name)
		var direction = (global_position-hit_position).normalized()
		Hit.emit(direction, damage, hitstun)
		$EffectAnimations.play("hitAnimation")
		
		
func Die():
	is_dead = true
	$UI/HealthBar.visible = false
	if(is_instance_valid($CollisionShape2D)):
		$CollisionShape2D.queue_free()
	#$Art/BlueHat.visible = false
	#$Art/RedHat.visible = false
	Died.emit()
	$MovementAnimations.play("Die")
	
