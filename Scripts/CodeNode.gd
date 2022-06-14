extends Control
class_name CodeNode
tool 

enum Types {
	Position
	Addition
	Constant
}
export (Types) var type setget set_type

onready var arrows := [
	$OutArrow1,
	$OutArrow2,
	$InArrow1, 
	$InArrow2
]

var outgoing_lines := {}
var incoming_lines := {}

signal moved(by)

func _ready():
	connect("moved", self, "_moved")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		
		var touched_arrow := false
		
		# loops through all the arrows to see if mouse touched any
		for arrow in arrows:
			
			if not arrow.visible: continue
			
			# if mouse did touch an arrow,
			if arrow.get_global_rect().has_point(get_global_mouse_position()):
				var arrow_index: int = int(arrow.name[-1]) - 1
				var arrow_side: String = "Out" if arrow.name.begins_with("Out") else "In"
				
				# if player is already holding a line while touching an arrow
				if Globals.held_line:
					
					if arrow_side == "Out":
						break
					
					# connect these lines
					print("Connected nodes ", Globals.held_line.original_node, " and ", self)
					Globals.held_line.to_node = self
					incoming_lines[arrow_index] = Globals.held_line
					Globals.held_line = null
					touched_arrow = true
					
					# then break and don't create another line
					break
				
				if outgoing_lines.has(arrow_index):
					outgoing_lines[arrow_index].delete()
				
				# create a new line
				var line: ConnectorLine = preload("res://Scenes/ConnectorLine.tscn").instance()
				add_child(line)
				line.original_node = self
				line.position = arrow.rect_position + Vector2(11, 14)
				line.arrow_index = arrow_index
				line.add_point(Vector2())
				line.add_point(get_global_mouse_position())
				
				Globals.held_line = line
				outgoing_lines[arrow_index]=line
				touched_arrow = true
		
		if not touched_arrow and $Sprite.get_global_rect().has_point(get_global_mouse_position()):
			get_parent().selected_node = self
			if Globals.held_line: Globals.held_line.delete()

func _moved(by: Vector2):
	
	for line in outgoing_lines.values():
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos - by * 80)
	
	for line in incoming_lines.values():
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos + by * 80)

func set_type(val: int):
	type = val
	
	if arrows:
		for arrow in arrows: arrow.show()
	$TextEdit.hide()
	
	match val:
		Types.Position:
			$Label.text = "Position"
			$Sprite.modulate = Color("541e1e")
		Types.Addition:
			$Label.text = "Addition"
			$Sprite.modulate = Color(0.668902, 0.671875, 0.291321)
			$OutArrow2.hide()
		Types.Constant:
			$Label.text = "Enter Number:"
			$Sprite.modulate = Color(0.104675, 0.397672, 0.957031)
			$TextEdit.show()
			$InArrow1.hide()
			$InArrow2.hide()
			$OutArrow2.hide()

func delete():
	queue_free()
