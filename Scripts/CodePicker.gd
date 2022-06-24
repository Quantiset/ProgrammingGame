extends Control

const MAX_ZOOM = 2
const ZOOM_MULTIPLICITY = 0.8

var is_mouse_held := false
var mouse_start_pos: Vector2

var selected_node
var is_holding_selected_node := false

var cached_pos: Vector2

func _ready():
	
	var i := 0
	for child in get_children():
		if child.is_in_group("CodeNode"):
			child.rect_position = Vector2(i * 80, 0)

func _input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				is_mouse_held = event.is_pressed()
				mouse_start_pos = get_node("../../../..").get_local_mouse_position()
				
				if selected_node != null:
					if not is_holding_selected_node:
						is_holding_selected_node = true
					elif event.is_pressed():
						selected_node = null
						is_holding_selected_node = false
	
	if get_node("../../../..").get_local_mouse_position().x < get_node("../../..").rect_position.x:
		return
	
	if event is InputEventMouseMotion:
		if is_mouse_held:
			$Camera2D.position -= event.relative
		elif selected_node != null:
			var _c = (get_local_mouse_position() + event.relative - Vector2(80, 120)).snapped(Vector2(40, 40))
			if _c != cached_pos:
				selected_node.emit_signal("moved", (_c-selected_node.rect_position)/80)
				selected_node.rect_position = _c
				cached_pos = _c
	



func _on_StartButton_pressed():
	print("H")
	for setter in get_tree().get_nodes_in_group("Setter"):
		setter.parse()
