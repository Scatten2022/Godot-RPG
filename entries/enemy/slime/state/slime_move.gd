class_name SlimeMove
extends SlimeBaseState

@export var move_speed: float = 10

var move_direction: Vector2
var wander_time: float

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter(state: StringName) -> void:
	super.Enter(state)
	randomize_wander()
	if slime:
		slime.animation_player.play("move")

func Update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta

func Physics_update(delta: float) -> void:
	if slime:
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		
		slime.velocity = move_direction * move_speed
		slime.graphics.scale.x = 1 if slime.velocity.x >= 0 else -1
		slime.move_and_slide()

func Process_last_frame_of_loop_animation() -> void:
	if slime and player:
		var direction: Vector2 = player.global_position - slime.global_position
		if direction.length() <= follow_distance_max and direction.length() > attack_radius_max:
			Transitioned.emit(self, "slimefollow")
			return
		elif direction.length() <= attack_radius_max:
			Transitioned.emit(self, "slimeattack")
			return
	
	if wander_time <= 0:
		Transitioned.emit(self, "slimeidle")


