extends KinematicBody2D
tool

export (Color) var color = Color(1,1,1) setget set_color
export (Color) var edge_color = Color(1,1,1) setget set_edge_color

var is_mouse_hovered := false

var velocity := Vector2()

func _ready():
	$VelocityArrow.set_as_toplevel(true)

func _input(event):
	if event is InputEventMouseMotion:
		if get_global_mouse_position().abs().x < $CollisionShape2D.shape.extents.x and \
		get_global_mouse_position().abs().y < $CollisionShape2D.shape.extents.y:
			_on_Ball_mouse_entered()
		else:
			_on_Ball_mouse_exited()

func set_pos(val: Vector2):
	$VelocityArrow.append_point(position)
	$VelocityArrow.append_point(position + val)
	$MovementTween.interpolate_property(self, "position", position, position + val, 1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$MovementTween.start()

func set_color(val: Color):
	$Sprite.material.set_shader_param("obj_color", val)
	color = val

func set_edge_color(val: Color):
	$Sprite.material.set_shader_param("line_color", val)
	edge_color = val


func _on_Ball_mouse_entered():
	is_mouse_hovered = true
	$Sprite.material.set_shader_param("line_thickness", 4)

func _on_Ball_mouse_exited():
	is_mouse_hovered = false
	$Sprite.material.set_shader_param("line_thickness", 0)


