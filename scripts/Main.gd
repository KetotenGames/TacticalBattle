# Main.gd
class_name Main
extends Node2D

enum Turn{PLAYER, ENEMY}
var turn = Turn.PLAYER

@onready var unit = $Unit
@onready var enemy = $Enemy
@onready var highlight_layer = $HighlightLayer

var selected_unit: Node = null

func _unhandled_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var pos = event.position
		if unit.get_rect().has_point(unit.to_local(pos)):
			if selected_unit != null:
				selected_unit.set_selected(false)	# 既に選択していた場合は解除
			selected_unit = unit
			# 選択ハイライト処理
			selected_unit.set_selected(true)
			
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if selected_unit != null:
			var map_pos = highlight_layer.local_to_map(event.position)
			# 移動範囲チェック
			selected_unit.move_to(map_pos)

func end_player_turn():
	turn = Turn.ENEMY
	enemy.take_action()
	turn = Turn.PLAYER
	
func can_attack(target_tile: Vector2i, self_tile: Vector2i):
	return abs(target_tile.x - self_tile.x) + abs(target_tile.y - self_tile.y) == 1
