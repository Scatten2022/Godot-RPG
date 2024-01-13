class_name Player
extends CharacterBody2D


const SPEED: float = 300

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var graphics: Node2D = $Graphics

var previous_direction: Vector2 = Vector2.DOWN

