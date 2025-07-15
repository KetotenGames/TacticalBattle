# Character.gd
class_name Character
extends Sprite2D

var is_moving = false
var move_tween: Tween = null

var move_range: int = -1

func _ready() -> void:
	assert(move_range > 0, "子クラスでmove_rangeを必ずセットするように")

func move_to(tile_pos: Vector2i, hl: HighlightLayer):
	if is_moving:
		return
	is_moving = true
	var target_pos = hl.map_to_local(tile_pos)
	move_tween = create_tween()
	move_tween.tween_property(self, "position", target_pos, 0.3)
	move_tween.finished.connect(_on_move_finished)

func _on_move_finished():
	is_moving = false
