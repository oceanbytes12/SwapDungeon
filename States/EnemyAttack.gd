extends State
class_name EnemyAttack
signal Attacked

@export var enemy : CharacterBody2D
@export var move_speed := 40.0
@export var attack_range := 40.0
@export var attack_cooldown := 1.0

var colldown_time := 0.0

func make_attack():
	Attacked.emit()
	colldown_time = attack_cooldown
	
func Enter():
	make_attack()

func Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
		return
	var target_vector = target.global_position - enemy.global_position
	var target_distance = target_vector.length()
	if colldown_time > 0:
		colldown_time -= delta
	else:
		Transitioned.emit("Follow")


func Physics_Update(delta: float, target: CharacterBody2D):
	enemy.velocity = Vector2()
