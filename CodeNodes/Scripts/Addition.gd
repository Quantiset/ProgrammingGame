extends CodeNode


func get_value(arrow_idx: int):
	if arrow_idx == 0:
		return (
			(incoming_lines[0].original_node.get_value(0) if incoming_lines.has(0) else 0) +
			(incoming_lines[1].original_node.get_value(0) if incoming_lines.has(1) else 0)
		)
	return 0
