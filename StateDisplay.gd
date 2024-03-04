extends Label

@export var state_machine : StateMachine
func _process(delta):
	text = state_machine.current_state.name
