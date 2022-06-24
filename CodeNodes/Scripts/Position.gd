extends CodeNode

func _process(delta):
	parse()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ENTER:
				parse()

func parse():
	if incoming_lines.has(0) and incoming_lines[0].original_node.get_value(0) != null:
		selected_object.position.x = incoming_lines[0].get_value() * 80
	if incoming_lines.has(1) and incoming_lines[1].original_node.get_value(1) != null:
		selected_object.position.y = incoming_lines[1].get_value() * 80


