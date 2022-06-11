extends Control
class_name CodeNode

onready var arrows := [
	$OutArrow1,
	$OutArrow2,
	$InArrow1, 
	$InArrow2
]

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		
		for arrow in arrows:
			if arrow.get_global_rect().has_point(event.position):
				var line: ConnectorLine = preload("res://Scenes/ConnectorLine.tscn").instance()
				add_child(line)
				line.original_node = self
				line.position = arrow.rect_position + Vector2(11, 14)
				line.add_point(Vector2())
				line.add_point(get_global_mouse_position())
				
				if Globals.held_line:
					Globals.held_line.to_node = self
					print("Connected nodes ",Globals.held_line.original_node," and ",self)
				Globals.held_line = line
			
