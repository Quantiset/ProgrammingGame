extends CodeNode

enum Type {
	Block,
	Line,
	Mouse
}
export (Type) var type = Type.Block
export (NodePath) onready var line setget set_line

func _ready():
	set_line(line)
	help_info = "Takes in a Vector2 to set the position of the block to. Will set the position in respect of the origin"
	connect("connected", main, "code_node_connected")
	$Position.hide()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ENTER:
				parse()

func parse(anim := true):
	if type == Type.Block:
		for obj in get_tree().get_nodes_in_group("Moveable"):
			if incoming_lines.has(0):
				for node in get_tree().get_nodes_in_group("CodeNode"):
					node.selected_object = obj
				var pos = (incoming_lines[0].get_value() * 80)
				selected_object.set_pos(pos, anim)
				$Position.show()
				$Position.text = str(pos / 80)
	if type == Type.Line and incoming_lines.has(0):
		line.remove_point(1)
		line.add_point(incoming_lines[0].get_value() * 80)

func set_line(val):
	line = val
	if type != Type.Line: return
	if get_node(val) == null:
		return
	line = get_node(val)
	if line:
		$Sprite.modulate = line.modulate 
		$Label.text = "Set " + line.name
