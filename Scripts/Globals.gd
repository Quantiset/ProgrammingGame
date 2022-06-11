extends Node

const TILE_SIZE = Vector2(80, 80)

var held_line

func _process(delta):
	if held_line and is_instance_valid(held_line):
		held_line.remove_point(1)
		held_line.add_point(held_line.get_local_mouse_position())
