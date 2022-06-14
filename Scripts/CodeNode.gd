extends Control
class_name CodeNode
tool 

enum Types {
	Position
	Addition
}
export (Types) var type setget set_type

onready var arrows := [
	$OutArrow1,
	$OutArrow2,
	$InArrow1, 
	$InArrow2
]

var outgoing_lines := []
var incoming_lines := []

signal moved(by)

func _ready():
	connect("moved", self, "_moved")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		
		var touched_arrow := false
		for arrow in arrows:
			if arrow.get_global_rect().has_point(get_global_mouse_position()):
				
				if Globals.held_line:
					print("Connected nodes ",Globals.held_line.original_node," and ",self)
					Globals.held_line.to_node = self
					incoming_lines.append(Globals.held_line)
					Globals.held_line = null
					touched_arrow = true
					break
				
				var line: ConnectorLine = preload("res://Scenes/ConnectorLine.tscn").instance()
				add_child(line)
				line.original_node = self
				line.position = arrow.rect_position + Vector2(11, 14)
				line.add_point(Vector2())
				line.add_point(get_global_mouse_position())
				
				Globals.held_line = line
				outgoing_lines.append(line)
				touched_arrow = true
		
		if not touched_arrow and $Sprite.get_global_rect().has_point(get_global_mouse_position()):
			get_parent().selected_node = self
			if Globals.held_line: Globals.held_line.delete()

func _moved(by: Vector2):
	
	for line in outgoing_lines:
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos - by * 80)
	
	for line in incoming_lines:
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos + by * 80)

func set_type(val: int):
	type = val
	match val:
		Types.Position:
			$Label.text = "Position"
		Types.Addition:
			$Label.text = "Addition"

func delete():
	queue_free()
