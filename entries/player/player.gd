class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var graphics: Node2D = $Graphics
@onready var state_machine: Node = $StateMachine

var previous_direction: Vector2 = Vector2.DOWN

func _ready() -> void:
	state_machine.call_init_state()
