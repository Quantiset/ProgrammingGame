extends TextureRect
tool

enum Colors {
	White
	Vector
	Quaternion
}
export (Colors) var color := Colors.White setget set_color
var color_dict := {
	Colors.White: Color(1,1,1),
	Colors.Vector: Color(0.177762, 0.867188, 0.057587),
	Colors.Quaternion: Color(0.822912, 0.867188, 0.057587),
}

func _ready():
	 set_color(color)

func set_color(val):
	color = val
	modulate = color_dict[val]
