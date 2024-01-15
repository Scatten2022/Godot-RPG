class_name PlayerHurt
extends PlayerBaseState

const KNOCKBACK_AMOUNT: float = 10.0


func Enter(state: StringName) -> void:
	super.SetChildState(self)
	if player:
		player.invincible_timer.start()
		player.animation_player.set_speed_scale(1.0)
		if player.previous_direction.x != 0:
			player.animation_player.play("hurt_side")
		else:
			player.animation_player.play("hurt_up" if player.previous_direction.y < 0 else "hurt_down")
		player.stats.health -= player.pending_damage.amount
		var direction: Vector2 = player.pending_damage.source.global_position.direction_to(player.global_position)
		player.velocity = direction * KNOCKBACK_AMOUNT
		player.pending_damage = null
		print("player.health = ", player.stats.health)

func Physics_update(delta: float) -> void:
	if player:
		if player.stats.health == 0:
			Transitioned.emit(self, "playerdie")
			return
		
		if not player.animation_player.is_playing():
			Transitioned.emit(self, "playeridle")
		player.move_and_slide()


