extends CodeNode

func _ready():
	help_info = "Returns a [color=yellow]number[/color] that represents the length of the inputted [color=green]Vector2[/color]. Ex: (1,1) => sqrt(2)/2"

func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0):
		return incoming_lines[0].get_value().length()
	return 0
