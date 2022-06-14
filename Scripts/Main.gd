extends Node2D

const CAMERA_SPEED = 10

const ZOOM_MULTIPLICITY = 0.8
const MAX_ZOOM = 2
const MIN_ZOOM = 1

var is_mouse_held := false
var mouse_start_pos: Vector2

func _input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP:
				$Camera2D.zoom *= ZOOM_MULTIPLICITY
			BUTTON_WHEEL_DOWN:
				$Camera2D.zoom /= ZOOM_MULTIPLICITY
			BUTTON_LEFT:
				is_mouse_held = event.is_pressed()
				mouse_start_pos = event.position
	
	if mouse_start_pos.x > $CanvasLayer/HSplitContainer/MarginContainer.get_global_rect().position.x:
		return
	
	if event is InputEventMouseMotion:
		if is_mouse_held:
			$Camera2D.position -= event.relative * $Camera2D.zoom
	
	$Camera2D.zoom = $Camera2D.zoom.clamped(MAX_ZOOM)


func _ready():
	
	for code_node in get_tree().get_nodes_in_group("CodeNode"):
		code_node.selected_object = $Block
	


func _process(delta):
	
	$Camera2D.position.x += Input.get_axis("ui_left", "ui_right") * CAMERA_SPEED
	$Camera2D.position.y += Input.get_axis("ui_up", "ui_down") * CAMERA_SPEED
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()




func _on_HSplitContainer_unhandled_input(event):
	_unhandled_input(event)
