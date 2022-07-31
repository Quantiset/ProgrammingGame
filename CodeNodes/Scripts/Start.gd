extends CodeNode


func start_logic_chain():
	if outgoing_lines.has(0): outgoing_lines[0].advance()
