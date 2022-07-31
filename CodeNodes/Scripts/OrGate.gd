extends CodeNode


func advance():
	if outgoing_lines.has(0): outgoing_lines[0].advance()
