# TerrainLayer.gd
class_name TerrainLayer
extends TileMapLayer

const WALL_SOURCE_ID = 0
const WALL_ATLAS_COORDS = Vector2i(1, 0)

func is_wall(tile_pos: Vector2i) -> bool:
	var source_id = get_cell_source_id(tile_pos)
	var atlas_coords = get_cell_atlas_coords(tile_pos)
	return source_id == WALL_SOURCE_ID and atlas_coords == WALL_ATLAS_COORDS
	
func is_walkable(tile_pos: Vector2i) -> bool:
	return not is_wall(tile_pos) 
