extends CodeNode


func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ENTER:
				parse()

func parse():
	if incoming_lines.has(0):
		selected_object.set_pos(incoming_lines[0].get_value() * 80)

