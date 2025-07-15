# Main.gd
class_name Main
extends Node2D

enum Turn{PLAYER, ENEMY}
var turn = Turn.PLAYER

@onready var unit = $Unit
@onready var enemy = $Enemy
@onready var highlight_layer = $HighlightLayer

var selected_unit: Unit = null

func _ready() -> void:
	unit.position = highlight_layer.map_to_local(Vector2i(1, 1))

func _unhandled_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# ユニット選択
		var pos = event.position
		if unit.get_rect().has_point(unit.to_local(pos)):
			if selected_unit != null:
				selected_unit.set_selected(false)	# 既に選択していた場合は解除
			selected_unit = unit
			selected_unit.set_selected(true)
			# 選択時にハイライト更新
			highlight_layer.show_move_range(
				highlight_layer.local_to_map(selected_unit.position),
				selected_unit.move_range
			)
			
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if selected_unit != null:
			var map_pos = highlight_layer.local_to_map(event.position)
			if highlight_layer.is_in_move_range(map_pos):
				selected_unit.move_to(map_pos, highlight_layer)
				# 攻撃チェック
				selected_unit.try_attack_enemy()
				end_player_turn()
				# ハイライト更新、消去
				highlight_layer.clear_move_range()

func end_player_turn():
	turn = Turn.ENEMY
	enemy.take_action()
	turn = Turn.PLAYER
	
func can_attack(target_tile: Vector2i, self_tile: Vector2i):
	return abs(target_tile.x - self_tile.x) + abs(target_tile.y - self_tile.y) == 1
