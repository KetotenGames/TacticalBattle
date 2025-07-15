# Main.gd
class_name Main
extends Node2D

enum Turn{PLAYER, ENEMY}
var turn = Turn.PLAYER

@onready var enemy = $Enemy
@onready var highlight_layer = $HighlightLayer

func end_player_turn():
	turn = Turn.ENEMY
	enemy.take_action()
	turn = Turn.PLAYER
	
func can_attack(target_tile: Vector2i, self_tile: Vector2i):
	return abs(target_tile.x - self_tile.x) + abs(target_tile.y - self_tile.y) == 1
