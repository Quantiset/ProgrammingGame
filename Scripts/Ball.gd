extends KinematicBody2D
tool

export (Color) var color = Color(1,1,1) setget set_color
export (Color) var edge_color = Color(1,1,1) setget set_edge_color

var is_mouse_hovered := false

func set_color(val: Color):
	$Sprite.material.set_shader_param("obj_color", val)
	color = val

func set_edge_color(val: Color):
	$Sprite.material.set_shader_param("line_color", val)
	edge_color = val


func _on_Ball_mouse_entered():
	is_mouse_hovered = true
	$Sprite.material.set_shader_param("line_thickness", 8)

func _on_Ball_mouse_exited():
	is_mouse_hovered = false
	$Sprite.material.set_shader_param("line_thickness", 0)


