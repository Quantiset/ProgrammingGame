extends CodeNode

enum Types {
	Sin,
	Cos,
	Tan
}
export (Types) var type 

func _ready():
	set_type(type)

func set_type(val: int):
	match val:
		Types.Sin:
			$Label.text = "Sin"
			help_info = "Returns a [color=yellow]number[/color] between 0 and 1 and smoothly cycles as input [color=yellow]number[/color] increases"
		Types.Cos:
			$Label.text = "Cos"
		Types.Tan:
			$Label.text = "Tan"

func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0):
		var incoming_value = incoming_lines[0].get_value()
		match type:
			Types.Sin:
				return sin(incoming_value)
			Types.Cos:
				return cos(incoming_value)
			Types.Tan:
				return tan(incoming_value)
	return 0
