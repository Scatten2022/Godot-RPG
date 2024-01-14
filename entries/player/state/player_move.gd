class_name PlayerMove
extends State

@export var player: CharacterBody2D

var walk_speed: float = 50
var run_speed: float = 100


func Physics_update(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		Transitioned.emit(self, "playerattack")
		return
	
	var direction_x: float = Input.get_axis("move_left", "move_right")
	var direction_y: float = Input.get_axis("move_up", "move_down")
	var direction: Vector2 = Vector2(direction_x, direction_y).normalized()
	var is_running: bool = Input.is_action_pressed("speed_up")
	if direction.length() == 0:
		Transitioned.emit(self, "playeridle")
		return
	
	if player:
		player.velocity = direction * (walk_speed if not is_running else run_speed)
		player.animation_player.set_speed_scale(1.0 if not is_running else 1.5)
		if direction_x != 0:
			player.animation_player.play("move_side")
			player.graphics.scale.x = 1 if player.velocity.x >= 0 else -1
			player.previous_direction = Vector2.LEFT if direction_x < 0 else Vector2.RIGHT
		else:
			player.animation_player.play("move_up" if direction_y < 0 else "move_down")
			player.graphics.scale.x = 1
			player.previous_direction = Vector2.UP if direction_y < 0 else Vector2.DOWN
		player.move_and_slide()
