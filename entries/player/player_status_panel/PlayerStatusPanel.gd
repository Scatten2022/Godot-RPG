extends HBoxContainer

@export var stats: Stats
@export var delay_time: float = 0.3
@export var ease_time: float = 0.5

@onready var health_bar = $HealthBar
@onready var eased_health_bar: TextureProgressBar = $HealthBar/EasedHealthBar


func _ready() -> void:
	assert(stats and stats != null)
	stats.health_changed.connect(update_health)
	update_health()

func update_health() -> void:
	assert(stats and stats != null)
	var percentage: float = stats.health / float(stats.max_health)
	health_bar.value = percentage
	
	create_tween().tween_property(
		eased_health_bar, "value", percentage, ease_time
	).set_ease(Tween.EASE_OUT).set_delay(delay_time)
