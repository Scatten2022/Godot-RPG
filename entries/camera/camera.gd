extends Camera2D

@export var DEFAULT_SHAKE_TIMER: float = 0.1
@export var DEFAULT_X_OFFSET: float = 1
@export var DEFAULT_Y_OFFSET: float = 1
@export var player: Player
@export var tile_map: TileMap

var shake_timer: float
var _shake_count_timer: float = 0
var _shake_offset:Vector2 = offset
var x_offset: float = 2
var y_offset: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		player.connect("shake_camera", shake)
	if tile_map:
		var used := tile_map.get_used_rect()
		var tile_size := tile_map.tile_set.tile_size
		
		limit_top = used.position.y * tile_size.y + tile_size.y / 3
		limit_bottom = used.end.y * tile_size.y - tile_size.y / 3
		limit_left = used.position.x * tile_size.x + tile_size.x / 3
		limit_right = used.end.x * tile_size.x - tile_size.x / 3
		reset_smoothing()
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	offset = _shake_offset + Vector2(randf_range(1, -1) * x_offset, randf_range(1, -1) * y_offset)
	if _shake_count_timer < shake_timer:
		_shake_count_timer += delta
	else:
		_shake_count_timer = 0
		offset = Vector2.ZERO
		_shake_offset = offset
		set_process(false)

func _physics_process(delta: float) -> void:
	if player and player != null:
		position = player.position

func shake(time: float = DEFAULT_SHAKE_TIMER, x: float = DEFAULT_X_OFFSET, y: float = DEFAULT_Y_OFFSET) -> void:
	shake_timer = time
	x_offset = x
	y_offset = y
	set_process(true)
