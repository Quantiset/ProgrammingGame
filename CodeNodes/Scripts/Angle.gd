extends CodeNode


func _ready():
	help_info = "Converts the inputted [color=green]Vector2[/color] into a radian angle. Ex: (0, -1) => PI/2"

func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0):
		return incoming_lines[0].get_value().angle()
	return 0
