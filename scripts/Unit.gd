# Unit.gd
class_name Unit
extends Character

@onready var main = get_parent()
@onready var highlight_layer = main.get_node("HighlightLayer")
@onready var enemy = main.get_node("Enemy")

func _ready() -> void:
	move_range = 2
	super()

func try_attack_enemy():
	var player_tile = highlight_layer.local_to_map(position)
	var enemy_tile = highlight_layer.local_to_map(enemy.position)
	if main.can_attack(player_tile, enemy_tile):
		print("Player attacks enemy!")
		# 攻撃処理
		return true
	return false
	
func set_selected(selected: bool):
	modulate = Color(1, 1, 1, 1) if not selected else Color(1, 1, 0.5, 1)
