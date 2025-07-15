# HighlightLayer.gd
class_name HighlightLayer
extends TileMapLayer

@onready var terrain_layer = get_parent().get_node("TerrainLayer")

# プレイヤーの移動力
var MOVE_RANGE = 2

var highlighted_tiles: Array = []

func _ready() -> void:
	pass
	
func get_unit_tile_pos(chara: Character) -> Vector2i:
	return local_to_map(chara.position)
	
func get_movable_tiles(center: Vector2i, move_range: int) -> Array:
	var open = [center]
	var visited = {center: 0}
	var result = []

	while open.size() > 0:
		var current = open.pop_front()
		var cost = visited[current]
		result.append(current)

		if cost >= move_range:
			continue

		for dir in [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)]:
			var next = current + dir
			if not terrain_layer.is_walkable(next):
				continue
			if next in visited:
				continue
			visited[next] = cost + 1
			open.append(next)

	return result

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
