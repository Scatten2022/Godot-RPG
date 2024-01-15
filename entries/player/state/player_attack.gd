class_name PlayerAttack
extends PlayerBaseState


func Enter(state: StringName) -> void:
	super.SetChildState(self)
	if player:
		player.animation_player.set_speed_scale(1.0)
		if player.previous_direction.x != 0:
			player.animation_player.play("attack_side")
		else:
			player.animation_player.play("attack_up" if player.previous_direction.y < 0 else "attack_down")

func Physics_update(delta: float) -> void:
	#super.Physics_update(delta)
	if player:
		if player.pending_damage and child_state.name.to_lower() != "playerhurt":
			Transitioned.emit(child_state, "playerhurt")
			return
		
		player.velocity = Vector2.ZERO
		if not player.animation_player.is_playing():
			Transitioned.emit(self, "playeridle")
			return
		player.move_and_slide()
