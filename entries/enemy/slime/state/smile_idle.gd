class_name SmileIdle
extends State

@export var slime: CharacterBody2D

var idle_time: float
var idle_direction: Vector2 = Vector2.ZERO

func randomize_idle() -> void:
	idle_time = randf_range(1, 3)

func Enter() -> void:
	randomize_idle()

func Update(delta: float) -> void:
	if idle_time > 0:
		idle_time -= delta

func Physics_update(delta: float) -> void:
	if slime:
		slime.velocity = Vector2.ZERO
		slime.animation_player.play("idle")
		slime.move_and_slide()

func Process_last_frame_of_loop_animation() -> void:
	if idle_time <= 0:
		Transitioned.emit(self, "slimemove")

