class_name SlimeBaseState
extends State

@export var slime: CharacterBody2D
@export var follow_distance_max: float = 70
@export var attack_radius_max: float = 17

var player: CharacterBody2D

func Enter(state: StringName) -> void:
	player = get_tree().get_first_node_in_group("Player")
