class_name SlimeHit
extends SlimeBaseState


func Enter(state: StringName) -> void:
	if slime:
		slime.animation_player.play("hit")
		slime.stats.health -= slime.pending_damage.amount
		slime.pending_damage = null
		print("slime.health = ", slime.stats.health)

func Physics_update(delta: float) -> void:
	if slime:
		if slime.stats.health == 0:
			Transitioned.emit(self, "slimedie")
		
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		
		if not slime.animation_player.is_playing():
			Transitioned.emit(self, "slimeidle")
			return
		slime.velocity = Vector2.ZERO
		slime.move_and_slide()
