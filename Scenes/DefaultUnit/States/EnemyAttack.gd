extends State
class_name EnemyAttack
signal Attacked
signal Targetted
signal Untarget

@export var own_body : CharacterBody2D

var colldown_time := 0.0

func make_attack():
	Attacked.emit()
	colldown_time = own_body.weaponCooldown
	
func Enter(target):
	Targetted.emit(target)
	make_attack()

func Exit():
	Untarget.emit()

func Update(delta: float, target: CharacterBody2D):
	if not target:
		Transitioned.emit("Idle")
		return
	if colldown_time > 0:
		colldown_time -= delta
	else:
		Transitioned.emit("Follow")


func Physics_Update(_delta: float, _target: CharacterBody2D):
	own_body.velocity = Vector2()
