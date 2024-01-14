class_name SlimeDie
extends SlimeBaseState


func Enter(state: StringName) -> void:
	print("slimedie enter")
	if slime:
		print("slimedie play animation")
		slime.animation_player.play("die")

func Physics_update(delta: float) -> void:
	if slime:
		if not slime.animation_player.is_playing():
			slime.queue_free()

