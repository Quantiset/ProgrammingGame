extends CodeNode

func _ready():
	connect("connected", get_node("../../../../../../.."), "code_node_connected")
	$Position.hide()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ENTER:
				parse()

func parse(anim := true):
	for obj in get_tree().get_nodes_in_group("Moveable"):
		if incoming_lines.has(0):
			for node in get_tree().get_nodes_in_group("CodeNode"):
				node.selected_object = obj
			var pos = (incoming_lines[0].get_value() * 80)
			selected_object.set_pos(pos, anim)
			$Position.show()
			$Position.text = str(pos / 80)

