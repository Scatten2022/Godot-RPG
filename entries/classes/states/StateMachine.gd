extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_update(delta)

func on_child_transition(state: State, new_state_name:StringName) -> void:
	if state != current_state:
		print("state != current_state")
		return
	
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		print("new_state is null")
		return
	
	if current_state:
		current_state.Exit()
	new_state.Enter(current_state.name.to_lower())
	current_state = new_state

func call_init_state() -> void:
	if initial_state:
		initial_state.Enter("init")
		current_state = initial_state

func process_last_frame_of_loop_animation() -> void:
	if current_state:
		current_state.Process_last_frame_of_loop_animation()



