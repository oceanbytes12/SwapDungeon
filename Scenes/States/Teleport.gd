extends State
class_name Teleport

@export var own_body : CharacterBody2D
@export var nextState : String
var Positions := [
	Vector2(-180, 80),
	Vector2(-180, -80),
	Vector2(180, 80),
	Vector2(180, -80)
]
@onready var currentPositions = Positions

func Enter(_target):
	own_body.velocity = Vector2.ZERO
	currentPositions.shuffle()
	own_body.position = currentPositions[0]
	currentPositions.remove_at(0)
	
	if(currentPositions.size() == 0):
		currentPositions = Positions
	
	Transitioned.emit(nextState)
