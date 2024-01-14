class_name SlimeFollow
extends SlimeBaseState

@export var follow_speed: float = 20


func Enter(state: StringName) -> void:
	super.Enter(state)
	if slime:
		slime.animation_player.play("move")

func Physics_update(delta: float) -> void:
	if slime and player:
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		
		var direction = player.global_position - slime.global_position
		slime.velocity = direction.normalized() * follow_speed
		slime.graphics.scale.x = 1 if slime.velocity.x >= 0 else -1
		slime.move_and_slide()

func Process_last_frame_of_loop_animation() -> void:
	if slime and player:
		var direction: Vector2 = player.global_position - slime.global_position
		if direction.length() > follow_distance_max:
			Transitioned.emit(self, "slimeidle")
		elif direction.length() <= attack_radius_max:
			Transitioned.emit(self, "slimeattack")

