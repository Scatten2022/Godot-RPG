class_name PlayerIdle
extends PlayerBaseState


func Enter(state: StringName) -> void:
	super.SetChildState(self)
	if player:
		player.animation_player.set_speed_scale(1.0)
		if player.previous_direction.x != 0:
			player.animation_player.play("idle_side")
		else:
			player.animation_player.play("idle_up" if player.previous_direction.y < 0 else "idle_down")

func Physics_update(delta: float) -> void:
	#super.Physics_update(delta)
	if player:
		if player.pending_damage and child_state.name.to_lower() != "playerhurt":
			Transitioned.emit(child_state, "playerhurt")
			return
		
		var direction_x: float = Input.get_axis("move_left", "move_right")
		var direction_y: float = Input.get_axis("move_up", "move_down")
		var direction: Vector2 = Vector2(direction_x, direction_y).normalized()
		if direction.length() > 0:
			Transitioned.emit(self, "playermove")
			return
		if Input.is_action_pressed("attack"):
			Transitioned.emit(self, "playerattack")
			return
	
		player.velocity = Vector2.ZERO
		player.move_and_slide()
