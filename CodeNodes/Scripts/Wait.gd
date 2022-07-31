extends CodeNode

export (float) var set_value := 99

func _ready():
	if not is_equal_approx(set_value, 99):
		$TextEdit.text = str(set_value)
		$TextEdit.readonly = true

func advance():
	yield(get_tree().create_timer(float($TextEdit.text)), "timeout")
	if outgoing_lines.has(0): outgoing_lines[0].advance()
