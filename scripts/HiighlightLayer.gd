# HighlightLayer.gd
class_name HighlightLayer
extends TileMapLayer

@onready var terrain_layer = get_parent().get_node("TerrainLayer")
@onready var unit = get_parent().get_node("Unit")

# プレイヤーの移動力
var MOVE_RANGE = 2

var highlighted_tiles: Array = []

func _ready() -> void:
	unit.position = map_to_local(Vector2i(1, 1))
	show_move_range(get_unit_tile_pos(), MOVE_RANGE)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		var tile_pos = local_to_map(event.position)
		if is_in_move_range(tile_pos):
			unit.position = map_to_local(tile_pos)
			clear_move_range()
			show_move_range(local_to_map(unit.position), MOVE_RANGE)
	
func get_unit_tile_pos() -> Vector2i:
	return local_to_map(unit.position)
	
func get_movable_tiles(center: Vector2i, move_range: int) -> Array:
	var tiles = []
	for dx in range(-move_range, move_range + 1):
		for dy in range(-move_range, move_range + 1):
			var pos = center + Vector2i(dx, dy)
			if abs(dx) + abs(dy) <= move_range and terrain_layer.is_walkable(pos):
				tiles.append(pos)
	return tiles

func is_in_move_range(tile_pos: Vector2i) -> bool:
	return tile_pos in highlighted_tiles

func show_move_range(center: Vector2i, move_range: int):
	highlighted_tiles = get_movable_tiles(center, move_range)
	print(highlighted_tiles)
	for tile in highlighted_tiles:
		set_cell(tile, 0, Vector2i(1, 1))
	
func clear_move_range():
	for tile in highlighted_tiles:
		set_cell(tile, -1)
	highlighted_tiles.clear()
