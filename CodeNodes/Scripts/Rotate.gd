extends CodeNode
tool

enum Measure {
	Degree90
	Radian
}
export (Measure) var measure = Measure.Degree90 setget set_measure

func _init():
	help_info = "Rotates a [color=green]Vector2[/color] by a [color=yellow]number[/color] of 90-degree turns"

func get_value(arrow_idx: int):
	if arrow_idx == 0 and incoming_lines.has(0):
		if not incoming_lines.has(1): return incoming_lines[0].get_value()
		if measure == Measure.Degree90:
			return incoming_lines[0].get_value().rotated(incoming_lines[1].get_value()*PI/2)
		else:
			return incoming_lines[0].get_value().rotated(incoming_lines[1].get_value())
	return Vector2()

func set_measure(val):
	measure = val
	match val:
		Measure.Degree90:
			$Label2.text = "90*"
			$Label2.modulate.g = 1
		Measure.Radian:
			$Label2.text = "radians"
			$Label2.modulate.g = 2
