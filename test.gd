extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var camera_2d: Camera2D = $Player/Camera2D

func _ready() -> void:
	var used := tile_map.get_used_rect()
	var tile_size := tile_map.tile_set.tile_size
	
	camera_2d.limit_top = used.position.y * tile_size.y + tile_size.y / 3
	camera_2d.limit_bottom = used.end.y * tile_size.y - tile_size.y / 3
	camera_2d.limit_left = used.position.x * tile_size.x + tile_size.x / 3
	camera_2d.limit_right = used.end.x * tile_size.x - tile_size.x / 3
	camera_2d.reset_smoothing()