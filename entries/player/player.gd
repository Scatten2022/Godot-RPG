class_name Player
extends CharacterBody2D


const SPEED: float = 300

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var graphics: Node2D = $Graphics

var previous_direction: Vector2 = Vector2.DOWN


func _physics_process(delta: float) -> void:
	if velocity.x != 0 and velocity.y != 0:
		animation_player.play("move_side")
		graphics.scale.x = 1 if velocity.x > 0 else -1
	elif velocity.y > 0:
		animation_player.play("move_down")
	elif velocity.y < 0:
		animation_player.play("move_up")
	else:
		animation_player.play("idle_down")
	
	move_and_slide()
