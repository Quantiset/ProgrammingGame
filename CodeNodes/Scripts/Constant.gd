extends CodeNode

export (float) var set_value := 99

func _ready():
	if not is_equal_approx(set_value, 99):
		$TextEdit.text = str(set_value)
		$TextEdit.readonly = true

func get_value(arrow_idx: int):
	if arrow_idx == 0: return int($TextEdit.text)
	return 0


func _on_TextEdit_text_changed():
	emit_signal("value_changed")
