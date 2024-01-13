class_name PlayerIdle
extends State

@export var player: CharacterBody2D


func Physics_update(delta: float) -> void:
	var direction_x: float = Input.get_axis("move_left", "move_right")
	var direction_y: float = Input.get_axis("move_up", "move_down")
	var direction: Vector2 = Vector2(direction_x, direction_y).normalized()
	if direction.length() > 0:
		Transitioned.emit(self, "playermove")
		return
	
	if player:
		if player.previous_direction.x != 0:
			player.animation_player.play("idle_side")
		else:
			player.animation_player.play("idle_up" if player.previous_direction.y < 0 else "idle_down")
		player.velocity = Vector2.ZERO
		player.move_and_slide()

