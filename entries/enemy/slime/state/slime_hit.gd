class_name SlimeHit
extends SlimeBaseState

const KNOCKBACK_AMOUNT: float = 10.0


func Enter(state: StringName) -> void:
	super.Enter(state)
	if slime:
		slime.animation_player.play("hit")
		slime.stats.health -= slime.pending_damage.amount
		var direction: Vector2 = slime.pending_damage.source.global_position.direction_to(slime.global_position)
		slime.velocity = direction * KNOCKBACK_AMOUNT
		slime.graphics.scale.x = -1 if direction.x > 0 else 1
		slime.pending_damage = null
		print("slime.health = ", slime.stats.health)

func Physics_update(delta: float) -> void:
	if slime:
		if slime.stats.health == 0:
			Transitioned.emit(self, "slimedie")
			return
		
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		
		if not slime.animation_player.is_playing():
			Transitioned.emit(self, "slimeidle")
			return
		slime.move_and_slide()
