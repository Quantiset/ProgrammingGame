extends Control

const MAX_ZOOM = 2
const ZOOM_MULTIPLICITY = 0.8

var help_mode := false
var is_mouse_held := false
var mouse_start_pos: Vector2

var selected_node
var is_holding_selected_node := false

var cached_pos: Vector2

onready var canvas = get_node("../../../..")
onready var main = get_node("../../../../../..")

func _ready():
	main.connect("help_clicked", self, "toggle_help")

func _input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				is_mouse_held = event.is_pressed()
				mouse_start_pos = canvas.get_local_mouse_position()
				
				if selected_node != null:
					if not is_holding_selected_node:
						is_holding_selected_node = true
					elif event.is_pressed():
						selected_node = null
						is_holding_selected_node = false
	
	if canvas.get_local_mouse_position().x < get_node("../../..").rect_position.x:
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
	for setter in get_tree().get_nodes_in_group("Setter"):
		if setter.has_method("parse"): setter.parse()

func toggle_help():
	print("HI")
	help_mode = not help_mode
	for node in get_tree().get_nodes_in_group("CodeNode"):
		if node.has_method("toggle_help"): node.toggle_help()
