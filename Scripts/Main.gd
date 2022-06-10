extends Node2D

const CAMERA_SPEED = 10

const ZOOM_MULTIPLICITY = 0.8
const MAX_ZOOM = 2
const MIN_ZOOM = 1

func _input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP:
				$Camera2D.zoom *= ZOOM_MULTIPLICITY
			BUTTON_WHEEL_DOWN:
				$Camera2D.zoom /= ZOOM_MULTIPLICITY
	
	$Camera2D.zoom = $Camera2D.zoom.clamped(MAX_ZOOM)


func _ready():
	pass


func _process(delta):
	
	$Camera2D.position.x += Input.get_axis("ui_left", "ui_right") * CAMERA_SPEED
	$Camera2D.position.y += Input.get_axis("ui_up", "ui_down") * CAMERA_SPEED
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
