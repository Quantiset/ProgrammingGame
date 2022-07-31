extends CodeNode

var advanced_before_this_frame := false

func _process(delta):
	advanced_before_this_frame = false

func advance():
	if advanced_before_this_frame:
		if outgoing_lines.has(0): outgoing_lines[0].advance()
	advanced_before_this_frame = true
