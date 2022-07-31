extends CodeNode

export (Vector2) var set_value := Vector2(99, 99)

func _ready():
	if not set_value.is_equal_approx(Vector2(99, 99)):
		$TextEdit.text = str(set_value.x)
		$TextEdit.readonly = true
		$TextEdit2.text = str(set_value.y)
		$TextEdit2.readonly = true

func get_value(arrow_idx: int):
	if arrow_idx == 0: 
		return Vector2(float($TextEdit.text), float($TextEdit2.text))
	return Vector2()

func _on_TextEdit_text_changed():
	emit_signal("value_changed")
