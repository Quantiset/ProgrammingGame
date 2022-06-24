extends CodeNode


func get_value(arrow_idx: int):
	var vec := Vector2()
	if incoming_lines.has(0): vec = incoming_lines[0].get_value()
	return (vec.x if arrow_idx == 0 else vec.y)
