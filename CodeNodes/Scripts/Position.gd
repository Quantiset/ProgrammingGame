extends CodeNode


func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ENTER:
				if incoming_lines.has(0) and incoming_lines[0].original_node.get_value(0) != null:
					selected_object.position.x = incoming_lines[0].original_node.get_value(0) * 80
				if incoming_lines.has(1) and incoming_lines[1].original_node.get_value(1) != null:
					selected_object.position.y = incoming_lines[1].original_node.get_value(0) * 80
					print(incoming_lines[1].original_node.get_value(1) * 80)

func get_value(arrow_idx: int):
	if arrow_idx == 0:
		return selected_object.position.x / 80
	elif arrow_idx == 1:
		return selected_object.position.y / 80
	else:
		return 0
