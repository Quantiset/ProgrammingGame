extends Line2D
class_name ConnectorLine

var original_node
var to_node

func delete():
	original_node.outgoing_lines.erase(self)
	if to_node: to_node.incoming_lines.erase(self)
	if Globals.held_line == self: Globals.held_line = null
	queue_free()
