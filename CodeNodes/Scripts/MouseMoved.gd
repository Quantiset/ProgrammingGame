extends CodeNode


var last_mouse_pos := Vector2()

func _process(delta):
	if get_global_mouse_position() / 80 != last_mouse_pos:
		last_mouse_pos = get_global_mouse_position() / 80
		if outgoing_lines.has(0) and outgoing_lines[0].to_node: outgoing_lines[0].advance()
