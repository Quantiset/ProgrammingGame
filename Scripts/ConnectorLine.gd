extends Path2D
class_name ConnectorLine

const SPLINE_LENGTH = 50

var original_node
var to_node

var incoming_arrow_index: int
var outgoing_arrow_index: int

var cached_points: Array

func _process(delta):
	update()

func add_point(pos: Vector2):
	curve.add_point(pos, Vector2(-SPLINE_LENGTH, 0), Vector2(SPLINE_LENGTH, 0))

func remove_point(idx: int):
	curve.remove_point(idx)

func get_point_position(idx: int):
	return curve.get_point_position(idx)

func delete():
	original_node.outgoing_lines.erase(outgoing_arrow_index)
	if to_node: to_node.incoming_lines.erase(incoming_arrow_index)
	if Globals.held_line == self: Globals.held_line = null
	queue_free()

func _draw():
	var points = curve.get_baked_points()
	if points and hash(points) != hash(cached_points):
		draw_polyline(points, Color.white, 4, true)
		cached_points = points
