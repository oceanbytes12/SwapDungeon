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
#@export var skeleton_die_scene : PackedScene
@export var slowdown_penalty: float = 8 

signal Hit
signal WalkCommand
signal AttackCommand
signal Died

var selected = false
var targeted = false
var is_dead = false

# Vars related to slowing unit speed
var is_movement_slowed = false
var slowdown_time = 5
var slowdown_timer = 0
var orig_walkSpeed
var orig_runSpeed

@onready var hitEffect = preload("res://Scenes/RandomEffects/HitEffect.tscn")
@onready var healEffect = preload("res://Scenes/RandomEffects/HealEffect.tscn")
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
	
	# Save starting run speed in case this unit gets slowed
	orig_walkSpeed = walkSpeed
	orig_runSpeed = runSpeed
	

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
	
	# Slowdown countdown
	if (is_movement_slowed):
		if slowdown_timer >= 0:
			slowdown_timer = slowdown_timer - _delta
		else:
			# Restore original movement speed
			walkSpeed = orig_walkSpeed
			runSpeed = orig_runSpeed
			is_movement_slowed = false
			

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
		var newNode = healEffect.instantiate()
		newNode.global_position = global_position
		newNode.set_damage_text(damage*-1)
		get_parent().get_parent().add_child(newNode)
	if $UI/HealthBar.value <= 0:
		is_dead = true
		#$Skeleton_death.post_event()
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
		$EffectAnimations.play("hit_Animation_New")
		#$Skeleton_hit.post_event()
	

func take_hit_with_slowdown(hit_position, damage, slowdown=false, hitstun=50):
	$UI/HealthBar.value -= damage
	var newNode = hitEffect.instantiate()
	newNode.global_position = global_position
	newNode.set_damage_text(damage)
	get_parent().get_parent().add_child(newNode)
	
	if slowdown == true:
		Start_Slowdown()
	
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
		$EffectAnimations.play("hit_Animation_New")
			
		
func Die():
	is_dead = true
	$UI/HealthBar.visible = false
	if(is_instance_valid($CollisionShape2D)):
		$CollisionShape2D.queue_free()
	#$Art/BlueHat.visible = false
	#$Art/RedHat.visible = false
	Died.emit()
	$MovementAnimations.play("Die")
	
func Start_Slowdown():
	# First, reset speed to original in case it was already slowed
	walkSpeed = orig_walkSpeed
	runSpeed = orig_runSpeed
	
	# Apply slowdown penalty, start countdown timer
	slowdown_timer = slowdown_time
	walkSpeed = walkSpeed - slowdown_penalty
	runSpeed = runSpeed - slowdown_penalty
	
	# Make sure speed is never 0
	if walkSpeed <= 0: walkSpeed = 1
	if runSpeed <= 0: runSpeed = 1
	
	is_movement_slowed = true
