extends Control
class_name CodeNode
tool 

onready var arrows := []

var outgoing_lines := {}
var incoming_lines := {}

var length := 2 setget set_length

var selected_object
var has_keyboard_focus := false

signal moved(by)

func _ready():
	
	for child in get_children(): 
		if "Arrow" in child.name: 
			arrows.append(child)
	
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
					
					if arrow_side == "In" and incoming_lines.has(arrow_index):
						incoming_lines[arrow_index].delete()
					
					if arrow_side == "Out":
						break
					
					if arrow.modulate != Globals.held_line.modulate:
						break
					
					# connect these lines
					connected_node(Globals.held_line.original_node)
					Globals.held_line.to_node = self
					Globals.held_line.outgoing_arrow_index = arrow_index
					incoming_lines[arrow_index] = Globals.held_line
					Globals.held_line = null
					touched_arrow = true
					
					# then break and don't create another line
					break
				
				if outgoing_lines.has(arrow_index) and outgoing_lines[arrow_index]:
					outgoing_lines[arrow_index].delete()
				
				if arrow_side == "In":
					break
				
				# create a new line
				var line: ConnectorLine = preload("res://Scenes/ConnectorLine.tscn").instance()
				add_child(line)
				line.modulate = arrow.modulate
				line.original_node = self
				line.position = arrow.rect_position + Vector2(11, 14)
				line.incoming_arrow_index = arrow_index
				line.add_point(Vector2())
				line.add_point(get_local_mouse_position())
				
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

func set_length(val: int):
	if arrows.size() > 2:
		for arrow in arrows.slice(2, arrows.size()-1):
			arrow.queue_free()
		arrows.resize(2)
	
	length = val
	for i in range(1, length):
		var in_arrow = $InArrow1.duplicate()
		in_arrow.name = in_arrow.name.trim_suffix(in_arrow.name[-1]) + str(i + 1)
		in_arrow.rect_position.y = 72 + 80 * i
		add_child(in_arrow)
		
		var out_arrow = $OutArrow1.duplicate()
		out_arrow.name = out_arrow.name.trim_suffix(out_arrow.name[-1]) + str(i + 1)
		out_arrow.rect_position.y = 72 + 80 * i
		add_child(out_arrow)
		
		arrows.append(in_arrow)
		arrows.append(out_arrow)
	
	$Sprite.rect_size.y = val * 80 + 80

func get_value(arrow_idx: int):
	return 0

func delete():
	queue_free()

func connected_node(with: CodeNode):
	pass


func _on_TextEdit_focus_entered():
	has_keyboard_focus = true



