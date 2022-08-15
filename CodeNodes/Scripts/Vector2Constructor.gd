extends CodeNode

func _ready():
	help_info = "Create a [color=green]Vector2[/color] with two [color=yellow]number[/color] components"
	$Pointer.add_point(Vector2(75, 125))
	$Pointer.add_point(Vector2(75, 125))

var i := 0
func _process(delta):
	i += 1
	if i % 10 == 1:
		update_arrow()

func get_value(arrow_idx: int):
	var x = incoming_lines[0].get_value() if incoming_lines.has(0) else 0
	var y = incoming_lines[1].get_value() if incoming_lines.has(1) else 0
	var vec = Vector2(x,y)
	return vec

func connected_node(with: ConnectorLine):
	update_arrow()
	with.original_node.connect("value_changed", self, "_connected_node_value_changed", [with.original_node])

func update_arrow():
	var x = incoming_lines[0].get_value() if incoming_lines.has(0) else null
	var y = incoming_lines[1].get_value() if incoming_lines.has(1) else null
	if x != null and y != null:
		$Pointer.show()
		$Pointer.remove_point(1)
		$Pointer.add_point(Vector2(75, 125) + Vector2(x, y) * 20)

func _connected_node_value_changed(node):
	update_arrow()
