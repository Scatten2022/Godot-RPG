class_name PlayerAttack
extends State

@export var player: CharacterBody2D


func Enter(state: StringName) -> void:
	if player:
		player.animation_player.set_speed_scale(1.0)
		if player.previous_direction.x != 0:
			player.animation_player.play("attack_side")
		else:
			player.animation_player.play("attack_up" if player.previous_direction.y < 0 else "attack_down")

func Physics_update(delta: float) -> void:
	if player:
		player.velocity = Vector2.ZERO
		if not player.animation_player.is_playing():
			Transitioned.emit(self, "playeridle")
			return
		player.move_and_slide()
