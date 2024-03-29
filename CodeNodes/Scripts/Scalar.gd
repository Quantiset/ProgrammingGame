extends CodeNode

enum Types {
	Scalar,
	Divider
}
export (Types) var type = Types.Scalar setget set_type

func _ready():
	help_info = "Scales a [color=green]Vector2[/color] by a length. Ex: (-1,1) | 3 => (-3,3)"

func get_value(arrow_idx: int):
	if arrow_idx == 0:
		if type == Types.Scalar:
			return (
				(incoming_lines[0].get_value() if incoming_lines.has(0) else Vector2()) *
				(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
			)
		elif type == Types.Divider:
			return (
				(incoming_lines[0].get_value() if incoming_lines.has(0) else Vector2()) /
				(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
			)
	return Vector2()

func set_type(val):
	type = val
	match val:
		Types.Scalar:
			$Label.text = "Scalar"
		Types.Divider:
			$Label.text = "Divider"
