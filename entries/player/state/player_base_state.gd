class_name PlayerBaseState
extends State

@export var player: CharacterBody2D

var child_state: State = null

func SetChildState(child: State) -> void:
	if child:
		child_state = child

