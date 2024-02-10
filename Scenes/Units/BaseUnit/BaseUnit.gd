extends CharacterBody2D

# player, enemy
@export var type : String = "player"
@export var move_speed: float = 30
@export var starting_health: float = 100
@export var hit_splat_scene : PackedScene

@onready var health_bar = $HealthBar
var health

signal Died

func _ready():
	health = starting_health
	health_bar.max_value = starting_health
	health_bar.value = starting_health
	print(health)
	
func _physics_process(_delta):
	move_and_slide()
	
func take_hit(source_body, damage, knockback_amount, knockback_direction, freeze_time=0):
	health -= damage
	health_bar.value = health
	var hit_splat = hit_splat_scene.instantiate()
	hit_splat.global_position = global_position
	hit_splat.set_damage_text(damage)
	get_parent().get_parent().add_child(hit_splat)
	if health <= 0:
		Die()
	else:
		var direction = (global_position-source_body.global_position).normalized()
		$StateMachine.unit_hit(source_body, damage, knockback_amount, knockback_direction, freeze_time)
		$EffectAnimations.play("hitAnimation")
		
func Die():
	Died.emit(self)
	queue_free()
