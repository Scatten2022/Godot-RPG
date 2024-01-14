class_name SlimeAttack
extends SlimeBaseState


func Enter(state: StringName) -> void:
	super.Enter(state)
	if slime:
		slime.animation_player.play("attack")

func Physics_update(delta: float) -> void:
	if slime:
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		slime.velocity = Vector2.ZERO
		if not slime.animation_player.is_playing():
			Transitioned.emit(self, "slimeidle")
			return
		slime.move_and_slide()
