extends CodeNode

func get_value(arrow_idx: int):
	if arrow_idx == 0:
		return (
			(incoming_lines[0].get_value() if incoming_lines.has(0) else 0) *
			(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
		)
	return Vector2()
