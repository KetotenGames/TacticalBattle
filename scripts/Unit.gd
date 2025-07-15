# Unit.gd
class_name Unit
extends Sprite2D

@onready var main = get_parent()
@onready var hl = main.get_node("HighlightLayer")
@onready var enemy = main.get_node("Enemy")

var is_moving = false
var move_tween: Tween = null

func try_attack_enemy():
	var player_tile = hl.local_to_map(position)
	var enemy_tile = hl.local_to_map(enemy.position)
	if main.can_attack(player_tile, enemy_tile):
		print("Player attacks enemy!")
		# 攻撃処理
		return true
	return false
	
func set_selected(selected: bool):
	modulate = Color(1, 1, 1, 1) if not selected else Color(1, 1, 0.5, 1)
	
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
