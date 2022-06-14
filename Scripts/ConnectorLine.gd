extends Line2D
class_name ConnectorLine

var original_node
var to_node

var arrow_index: int

func delete():
	original_node.outgoing_lines.erase(arrow_index)
	if to_node: to_node.incoming_lines.erase(arrow_index)
	if Globals.held_line == self: Globals.held_line = null
	queue_free()
