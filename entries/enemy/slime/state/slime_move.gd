class_name SlimeMove
extends State

@export var slime: CharacterBody2D
@export var move_speed: float = 10

var move_direction: Vector2
var wander_time: float

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter() -> void:
	randomize_wander()

func Update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta

func Physics_update(delta: float) -> void:
	if slime:
		slime.velocity = move_direction * move_speed
		slime.animation_player.play("move")
		slime.graphics.scale.x = 1 if slime.velocity.x >= 0 else -1
		slime.move_and_slide()

func Process_last_frame_of_loop_animation() -> void:
	if wander_time <= 0:
		Transitioned.emit(self, "slimeidle")


