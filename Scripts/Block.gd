extends KinematicBody2D
tool

export (Color) var color = Color(1,1,1) setget set_color
export (Color) var edge_color = Color(1,1,1) setget set_edge_color

export (bool) var point_globally := false setget set_point_globally

var is_mouse_hovered := false

var velocity := Vector2()
var end_pos := Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		if get_global_mouse_position().abs().x < $CollisionShape2D.shape.extents.x and \
		get_global_mouse_position().abs().y < $CollisionShape2D.shape.extents.y:
			_on_Ball_mouse_entered()
		else:
			_on_Ball_mouse_exited()

func _process(delta):
	if $VelocityArrow.get_point_count() > 0 and not point_globally:
		$VelocityArrow.remove_point(1)
		$VelocityArrow.append_point(end_pos - position)

func set_pos(val: Vector2, anim := true):
	$VelocityArrow.show()
	$VelocityArrow.clear_points()
	$VelocityArrow.append_point(Vector2())
	$VelocityArrow.append_point(val)
	end_pos = val
	if anim:
		$MovementTween.interpolate_property(self, "position", position, val, 1,Tween.TRANS_QUAD,Tween.EASE_IN)
		$MovementTween.start()
	else:
		position = val

func set_color(val: Color):
	return
	$Sprite.material.set_shader_param("obj_color", val)
	color = val

func set_edge_color(val: Color):
	return
	$Sprite.material.set_shader_param("line_color", val)
	edge_color = val

func set_point_globally(val: bool):
	point_globally = val
	$VelocityArrow.set_as_toplevel(val)
	$VelocityArrow.modulate = (
		Color.yellow if point_globally else Color.green
	)

func _on_Ball_mouse_entered():
	is_mouse_hovered = true
	$Sprite.material.set_shader_param("line_thickness", 4)

func _on_Ball_mouse_exited():
	is_mouse_hovered = false
	$Sprite.material.set_shader_param("line_thickness", 0)


