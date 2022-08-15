extends CodeNode

func _ready():
	help_info = "Multiplies two [color=yellow]numbers[/color] together. Ex: 4 | 4 => 16"

func get_value(arrow_idx: int):
	if arrow_idx == 0:
		return (
			(incoming_lines[0].get_value() if incoming_lines.has(0) else 0) *
			(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
		)
	return 0
