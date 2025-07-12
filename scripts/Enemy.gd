# Enemy.gd
class_name Enemy
extends Sprite2D

@onready var unit = self  # 敵自身
@onready var player = get_parent().get_node("Unit")

func _ready() -> void:
	position = get_parent().get_node("HighlightLayer").map_to_local(Vector2i(6, 2))

func take_action():
	var hl = get_parent().get_node("HighlightLayer")
	var player_tile = hl.local_to_map(player.position)
	var enemy_tile = hl.local_to_map(position)

	var diff = player_tile - enemy_tile
	var move = Vector2i(
		diff.x / abs(diff.x) if diff.x != 0 else 0,
		diff.y / abs(diff.y) if diff.x == 0 and diff.y != 0 else 0
	)
	var next_tile = enemy_tile + move
	position = hl.map_to_local(next_tile)
