extends Node

@export var default_color: Color = Color.AZURE
@export var default_rising_height: float = 25
@export var default_rising_time: float = 0.25
@export var default_stationary_time: float = 0
@export var default_descent_height: float = 25
@export var default_descent_time: float = 0.5
@export var default_scale_time: float = 0.25
@export var default_z_index: int = 5
@export var default_font: Font
@export var default_damage_value_size: float = 10
@export var default_outline_color: Color = Color.BLACK
@export var default_outline_size: float = 1


func display_damage_number(damage_value: int, float_position: Vector2,
		damage_color: Color = default_color) -> void:
	display_damage_number_with_full_params(damage_value, float_position, damage_color,
		default_rising_height, default_rising_time, default_stationary_time,
		default_descent_height, default_descent_time, default_scale_time)


func display_damage_number_with_full_params(damage_value: int, float_position: Vector2,
		damage_color: Color, rising_height: float, rising_time: float, stationary_time: float,
		descent_height: float, descent_time: float, scale_time: float) -> void:
	var total_time: float = rising_time + stationary_time + descent_time - scale_time
	var number = Label.new()
	number.global_position = float_position
	number.text = str(damage_value)
	number.z_index = default_z_index
	number.label_settings = LabelSettings.new()
	
	
	number.label_settings.font_color = damage_color
	number.label_settings.font_size = default_damage_value_size
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 3
	if default_font:
		number.label_settings.font = default_font
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	number.global_position -= number.size / 2
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - rising_height, rising_time
	).set_ease(Tween.EASE_OUT)
	tween.tween_interval(stationary_time)
	tween.tween_property(
		number, "position:y", number.position.y - rising_height + descent_height, descent_time
	).set_ease(Tween.EASE_IN).set_delay(rising_time + stationary_time)
	tween.tween_property(
		number, "scale", Vector2.ZERO, scale_time
	).set_ease(Tween.EASE_IN).set_delay(rising_time + stationary_time + descent_time - scale_time)
	tween.tween_property(
		number, "position:x", number.position.x + randf_range(-10, 10), total_time
	).set_ease(Tween.EASE_IN)
	
	
	await tween.finished
	number.queue_free()
