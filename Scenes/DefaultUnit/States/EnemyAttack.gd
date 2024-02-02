extends State
class_name EnemyAttack
signal Attacked
signal Targetted
signal Untarget

@export var own_body : CharacterBody2D
var can_attack = true
var range_buffer = 2 #This is to prevent jittering between follow and attack states

func Enter(target):
	Targetted.emit(target)

func Exit():
	Untarget.emit()

func Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
		return
	var target_vector = target.global_position - own_body.global_position
	var target_distance = target_vector.length()
	if target_distance > own_body.weaponRange + range_buffer:
		Transitioned.emit("Follow")
	if can_attack:
		own_body.velocity = target_vector
		can_attack = false
		Attacked.emit()
		$Timer.wait_time = own_body.weaponCooldown
		$Timer.start()


func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2()


func _on_timer_timeout():
	can_attack = true
