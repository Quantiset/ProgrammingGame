extends CodeNode

func _ready():
	help_info = "Normalizes the input [color=green]Vector2[/color] to be of length [color=yellow]1[/color]. Ex: (2, 0) => (1, 0)"

func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0): 
		return incoming_lines[0].get_value().normalized()
	return Vector2()
