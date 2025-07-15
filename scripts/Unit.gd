# Unit.gd
class_name Unit
extends Sprite2D

@onready var main = get_parent()
@onready var hl = main.get_node("HighlightLayer")
@onready var enemy = main.get_node("Enemy")

func try_attack_enemy():
	var player_tile = hl.local_to_map(position)
	var enemy_tile = hl.local_to_map(enemy.position)
	if main.can_attack(player_tile, enemy_tile):
		print("Player attacks enemy!")
		# 攻撃処理
		return true
	return false
