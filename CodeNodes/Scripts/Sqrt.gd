extends CodeNode


func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0):
		var incoming_value = incoming_lines[0].get_value()
		return sqrt(incoming_value)
