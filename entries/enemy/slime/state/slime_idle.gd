class_name SlimeIdle
extends SlimeBaseState

var idle_time: float
var short_idle_time_state: Array = [
	"slimeattack",
	"slimehit",
]

func randomize_idle() -> void:
	idle_time = randf_range(1, 3)

func Enter(state: StringName) -> void:
	super.Enter(state)
	if short_idle_time_state.has(state):
		idle_time = 0.5
	else:
		randomize_idle()
	if slime:
		slime.animation_player.play("idle")

func Update(delta: float) -> void:
	if idle_time > 0:
		idle_time -= delta

func Physics_update(delta: float) -> void:
	if slime:
		if slime.pending_damage:
			Transitioned.emit(self, "slimehit")
			return
		
		slime.velocity = Vector2.ZERO
		slime.move_and_slide()

func Process_last_frame_of_loop_animation() -> void:
	if idle_time <= 0:
		if slime and player != null:
			var direction: Vector2 = player.global_position - slime.global_position
			if direction.length() <= follow_distance_max and direction.length() > attack_radius_max:
				Transitioned.emit(self, "slimefollow")
				return
			elif direction.length() <= attack_radius_max:
				Transitioned.emit(self, "slimeattack")
				return
		Transitioned.emit(self, "slimemove")
