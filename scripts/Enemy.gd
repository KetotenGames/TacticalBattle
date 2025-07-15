# Enemy.gd
class_name Enemy
extends Character

@onready var unit = self  # 敵自身
@onready var main: Main = get_parent()
@onready var highlight_layer: HighlightLayer = main.get_node("HighlightLayer")



func _ready() -> void:
	move_range = 1
	super()
	position = get_parent().get_node("HighlightLayer").map_to_local(Vector2i(6, 2))
	

func take_action():
	var player = get_parent().get_node("Unit")
	var player_tile = highlight_layer.local_to_map(player.position)
	var enemy_tile = highlight_layer.local_to_map(position)
	
	if main.can_attack(player_tile, enemy_tile):
		print("Enemy attacks player!")
		return

	var diff = player_tile - enemy_tile
	var move = Vector2i(
		diff.x / abs(diff.x) if diff.x != 0 else 0,
		diff.y / abs(diff.y) if diff.x == 0 and diff.y != 0 else 0
	)
	var next_tile = enemy_tile + move
	# position = hl.map_to_local(next_tile)
	move_to(next_tile, highlight_layer)
