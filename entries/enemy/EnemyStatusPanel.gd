extends HBoxContainer

var first_set: bool = true

@export var stats: Stats
@export var delay_time: float = 0.3
@export var ease_time: float = 0.5

@onready var health_bar = $HealthBar
@onready var eased_health_bar: TextureProgressBar = $HealthBar/EasedHealthBar
@onready var show_timer: Timer


func _ready() -> void:
	assert(stats and stats != null)
	stats.health_changed.connect(update_health)
	update_health()
	health_bar.set_visible(false)
	show_timer = Timer.new()
	show_timer.one_shot = true
	show_timer.wait_time = 3
	show_timer.autostart = false
	show_timer.timeout.connect(_show_timer_timeout)
	add_child(show_timer)

func update_health() -> void:
	assert(stats and stats != null)
	health_bar.set_visible(true)
	if not first_set:
		print("show_timer.start func called")
		show_timer.start()
	first_set = false
	var percentage: float = stats.health / float(stats.max_health)
	health_bar.value = percentage
	
	create_tween().tween_property(
		eased_health_bar, "value", percentage, ease_time
	).set_ease(Tween.EASE_OUT).set_delay(delay_time)

func _show_timer_timeout() -> void:
	print("set health_bar.visibility in _show_timer_timeout func")
	health_bar.set_visible(false)
