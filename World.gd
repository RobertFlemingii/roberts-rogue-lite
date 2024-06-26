extends Node2D

var borders = Rect2(1, 1, 38, 21)

onready var tileMap = $TileMap
onready var bullet_manager = $BulletManager
onready var player = $Player

func _ready():
	randomize()
	generate_level()
	player.connect("player_fired_bullet", bullet_manager, "handle_bullet_spawned")

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(500)
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
