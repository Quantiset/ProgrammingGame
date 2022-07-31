extends Button
tool

enum Types {
	Once,
	Process,
	Custom
}

export (Types) var type := Types.Once setget set_type

func set_type(val: int):
	match val:
		Types.Once:
			$Polygon2D.color = Color("b91f9727")
			$Label.text = "Run"
			$Line2D.modulate.a = 1
		Types.Process:
			$Polygon2D.color = Color("b988971f")
			$Label.text = "Start >|"
			$Line2D.modulate.a = 1
		Types.Custom:
			$Polygon2D.color = Color("b91f2197")
			$Label.text = "Start Logic"
			$Line2D.modulate.a = 1
	type = val
