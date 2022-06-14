extends CodeNode

func get_value(arrow_idx: int):
	if arrow_idx == 0: return int($TextEdit.text)
	return 0
