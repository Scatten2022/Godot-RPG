extends Enemy

@onready var state_machine: Node = $StateMachine

var pending_damage: Damage = null


func _ready() -> void:
	state_machine.call_init_state()

func _process_last_frame_of_loop_animation() -> void:
	state_machine.process_last_frame_of_loop_animation()

func _on_hurt_box_hurt(hit_box: HitBox) -> void:
	pending_damage = Damage.new()
	pending_damage.amount = 1
	pending_damage.source = hit_box.owner
