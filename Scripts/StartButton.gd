extends Button
tool

enum Types {
	Once,
	Process
}

export (Types) var type := Types.Once setget set_type

func set_type(val: int):
	match val:
		Types.Once:
			$Polygon2D.color = Color("b91f9727")
			$Label.text = "Run"
		Types.Process:
			$Polygon2D.color = Color("b988971f")
			$Label.text = "Start >|"
	type = val
