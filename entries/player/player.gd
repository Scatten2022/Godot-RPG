class_name Player
extends CharacterBody2D

var previous_direction: Vector2 = Vector2.DOWN
var pending_damage: Damage = null
var count: int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var graphics: Node2D = $Graphics
@onready var state_machine: Node = $StateMachine
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var stats: Stats = $Stats
@onready var float_damage_position: Marker2D = $FloatDamagePosition
@onready var float_damage_player: Node = $FloatDamagePlayer

signal shake_camera(time: float, x_offset: float, y_offset: float)

func _ready() -> void:
	assert(state_machine, "Plase check state_machine in player!")
	state_machine.call_init_state()

func _process(delta: float) -> void:
	if invincible_timer.time_left > 0:
		graphics.modulate.a = sin(Time.get_ticks_msec() / 20) * 0.5 + 0.5
	else:
		graphics.modulate.a = 1

func _on_hurt_box_hurt(hit_box: HitBox) -> void:
	if invincible_timer.time_left > 0:
		return
	
	pending_damage = Damage.new()
	pending_damage.amount = 2
	pending_damage.source = hit_box.owner
	float_damage_player.display_damage_number(pending_damage.amount, float_damage_position.global_position, Color.BLUE)
	shake_camera.emit()


func _on_hit_box_hit(hurt_box: HurtBox) -> void:
	shake_camera.emit()
