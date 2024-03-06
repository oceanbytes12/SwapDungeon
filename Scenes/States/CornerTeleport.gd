extends State
class_name CornerTeleport

@export var own_body : CharacterBody2D
@export var nextState : String
@export var state_duration : float
var current_state_duration

var Positions := [
	Vector2(-180, 80),
	Vector2(-180, -80),
	Vector2(180, 80),
	Vector2(180, -80)
]

@onready var currentPositions = Positions

func Enter(_own_body, _target, _target_list):
	current_state_duration = state_duration
	own_body.velocity = Vector2.ZERO
	currentPositions.shuffle()
	own_body.position = currentPositions[0]
	currentPositions.remove_at(0)
	
	if(currentPositions.size() == 0):
		currentPositions = Positions

func Update(_delta, own_body, current_target, target_list, walk_target):
	current_state_duration -= _delta
	if(current_state_duration <= 0):
		ChangeState.emit(nextState, current_target, walk_target)
