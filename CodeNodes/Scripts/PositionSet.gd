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
	if incoming_lines.has(0):
		var pos = (incoming_lines[0].get_value() * 80)
		selected_object.set_pos(pos, anim)
		$Position.show()
		$Position.text = str(pos / 80)

