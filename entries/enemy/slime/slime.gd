extends Enemy

@onready var state_machine: Node = $StateMachine

func _process_last_frame_of_loop_animation() -> void:
	state_machine.process_last_frame_of_loop_animation()

