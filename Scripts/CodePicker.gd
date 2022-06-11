extends Control

const MAX_ZOOM = 2
const ZOOM_MULTIPLICITY = 0.8

var is_mouse_held := false
var mouse_start_pos: Vector2

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP:
				$Camera2D.zoom *= ZOOM_MULTIPLICITY
			BUTTON_WHEEL_DOWN:
				$Camera2D.zoom /= ZOOM_MULTIPLICITY
			BUTTON_LEFT:
				is_mouse_held = event.is_pressed()
				mouse_start_pos = event.position
	
	if mouse_start_pos.x < get_parent().get_global_rect().position.x:
		return
	
	if event is InputEventMouseMotion:
		if is_mouse_held:
			rect_position += event.relative
	
