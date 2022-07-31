extends Control
class_name CodeNode
tool

onready var arrows := []

var outgoing_lines := {}
var incoming_lines := {}

var length := 2 setget set_length

var selected_object
var has_keyboard_focus := false
var help_mode := false

export (bool) var locked := false setget set_locked

var parse_input_this_frame := true

signal moved(by)
signal connected(line)
signal value_changed()

export (Array, Resource) var custom_connections

onready var main = get_node("../../../../../../..")

var help_info := ""

func _ready():
	
	for connection in custom_connections:
		var to_node = get_node(connection.connection)
		var from_idx = connection.connection_from_idx
		var to_idx = connection.connection_to_idx
		var line: ConnectorLine = create_line(
			get_node("OutArrow"+str(from_idx+1)), from_idx
		)
		line.add_point(
			(to_node.get_node("InArrow"+str(to_idx+1)).rect_global_position + Globals.HALF_ARROW_OFFSET) - 
			(get_node("OutArrow"+str(from_idx+1)).rect_global_position + Globals.HALF_ARROW_OFFSET)
		)
		line.set = true
		line.to_node = to_node
		line.outgoing_arrow_index = to_idx
		emit_signal("connected", line)
		connected_node(line)
		to_node.incoming_lines[to_idx] = line
		outgoing_lines[from_idx]=line
	
	for child in get_children(): 
		if "Arrow" in child.name: 
			arrows.append(child)
	
	connect("moved", self, "_moved")
	

func _input(event):
	
	if event is InputEventMouseMotion:
		if help_mode:
			if $Sprite.get_global_rect().has_point(get_global_mouse_position()):
				$HelpLabel.show()
			else:
				$HelpLabel.hide()
	
	if event is InputEventMouseButton and event.is_pressed() and parse_input_this_frame:
		
		var touched_arrow := false
		
		# loops through all the arrows to see if mouse touched any
		for arrow in arrows:
			
			if not arrow.visible: continue
			
			# if mouse did touch an arrow,
			if arrow.get_global_rect().has_point(get_global_mouse_position()):
				var arrow_index: int = int(arrow.name[-1]) - 1
				var arrow_side: String = "Out" if arrow.name.begins_with("Out") else "In"
				
				if arrow_side == "Out" and \
						outgoing_lines.has(arrow_index) and outgoing_lines[arrow_index].set:
					break
				
				# if player is already holding a line while touching an arrow
				if Globals.held_line:
					
					if arrow_side == "In" and incoming_lines.has(arrow_index):
						incoming_lines[arrow_index].delete()
					
					if arrow_side == "Out":
						break
					
					if arrow.modulate != Globals.held_line.modulate:
						break
					
					# connect these lines
					emit_signal("connected", Globals.held_line)
					Globals.held_line.to_node = self
					Globals.held_line.outgoing_arrow_index = arrow_index
					incoming_lines[arrow_index] = Globals.held_line
					connected_node(Globals.held_line)
					Globals.held_line = null
					touched_arrow = true
					
					# then break and don't create another line
					break
				
				if outgoing_lines.has(arrow_index) and outgoing_lines[arrow_index]:
					outgoing_lines[arrow_index].delete()
				
				if arrow_side == "In":
					break
				
				# create a new line
				var line: ConnectorLine = create_line(arrow, arrow_index)
				line.add_point(get_local_mouse_position())
				
				Globals.held_line = line
				outgoing_lines[arrow_index]=line
				touched_arrow = true
		
		if (not locked and not touched_arrow and 
		$Sprite.get_global_rect().has_point(get_global_mouse_position())):
			if hovering_over_a_text_edit():
				pass
			elif "selected_node" in get_parent():
				get_parent().selected_node = self
			if Globals.held_line: Globals.held_line.delete()
	
	parse_input_this_frame = true

func create_line(arrow, arrow_index) -> ConnectorLine:
	var line: ConnectorLine = preload("res://Scenes/ConnectorLine.tscn").instance()
	add_child(line)
	line.modulate = arrow.modulate
	line.original_node = self
	line.position = arrow.rect_position + Globals.HALF_ARROW_OFFSET
	line.incoming_arrow_index = arrow_index
	line.add_point(Vector2())
	return line

func _moved(by: Vector2):
	
	for line in outgoing_lines.values():
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos - by * 80)
	
	for line in incoming_lines.values():
		var og_pos = line.get_point_position(1)
		line.remove_point(1)
		line.add_point(og_pos + by * 80)

func set_locked(val: bool):
	$Lock.visible = val
	locked = val

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

func connected_node(with: ConnectorLine):
	pass

func _on_TextEdit_focus_entered():
	has_keyboard_focus = true
	parse_input_this_frame = false

func hovering_over_a_text_edit():
	for child in get_children():
		if "TextEdit" in child.name and child.get_global_rect().has_point(get_global_mouse_position()):
			return child.visible

func toggle_help():
	$HelpLabel.text = help_info
	help_mode = not help_mode

