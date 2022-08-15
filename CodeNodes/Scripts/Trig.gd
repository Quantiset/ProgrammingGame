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
			help_info = "Returns the sine of an input. Cycles between -1 and 1"
		Types.Cos:
			$Label.text = "Cos"
			help_info = "Returns the cosine of an input. Cycles between -1 and 1"
		Types.Tan:
			$Label.text = "Tan"
			help_info = "Returns the tangent of an input"

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
