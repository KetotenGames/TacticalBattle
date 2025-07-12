# Enemy.gd
class_name Enemy
extends Sprite2D

func _ready() -> void:
	position = get_parent().get_node("HighlightLayer").map_to_local(Vector2i(6, 2))
