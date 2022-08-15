extends CodeNode

enum Types {
	Addition, Subtraction
}
export (Types) var method = Types.Addition setget set_method

func get_value(arrow_idx: int):
	if arrow_idx == 0:
		if method == Types.Addition:
			return (
				(incoming_lines[0].get_value() if incoming_lines.has(0) else 0) +
				(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
			)
		elif method == Types.Subtraction:
			return (
				(incoming_lines[0].get_value() if incoming_lines.has(0) else 0) -
				(incoming_lines[1].get_value() if incoming_lines.has(1) else 0)
			)
	return 0

func set_method(val: int):
	method = val
	match val: 
		Types.Addition:
			$Label.text = "Addition"
			help_info = "Adds two numbers together. Ex: 3 | 3 => 6"
		Types.Subtraction:
			$Label.text = "Subtract"
			help_info = "Subtracts two numbers. Ex: 5 | 3 => 2"
