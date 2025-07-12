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
