class_name PlayerDie
extends PlayerBaseState

func Enter(state: StringName) -> void:
	super.SetChildState(self)
	if player:
		player.animation_player.set_speed_scale(1.0)
		player.animation_player.play("die")
		print("player.health = ", player.stats.health)

func Physics_update(delta: float) -> void:
	if player:
		if not player.animation_player.is_playing():
			player.queue_free()
			return
