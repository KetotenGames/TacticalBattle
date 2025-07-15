# Enemy.gd
class_name Enemy
extends Sprite2D

@onready var unit = self  # 敵自身
@onready var main: Main = get_parent()
@onready var hl: HighlightLayer = main.get_node("HighlightLayer")

var is_moving = false
var move_tween: Tween = null

func _ready() -> void:
	position = get_parent().get_node("HighlightLayer").map_to_local(Vector2i(6, 2))
	

func take_action():
	var hl = get_parent().get_node("HighlightLayer")
	var player = get_parent().get_node("Unit")
	var player_tile = hl.local_to_map(player.position)
	var enemy_tile = hl.local_to_map(position)
	
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
	move_to(next_tile)
		
func move_to(tile_pos: Vector2i):
	if is_moving:
		return	# 移動中は処理しない
		
	is_moving = true
	var target_pos = hl.map_to_local(tile_pos)
	move_tween = create_tween()
	move_tween.tween_property(self, "position", target_pos, 0.3)
	move_tween.finished.connect(_on_move_finished)
		
func _on_move_finished():
	is_moving = false
