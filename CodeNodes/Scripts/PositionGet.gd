extends CodeNode

enum Type {
	Block,
	Line,
	Mouse
}
export (Type) var type = Type.Block
export (NodePath) onready var line = line setget set_line

func _ready():
	set_line(line)
	yield(get_tree().create_timer(0.1), "timeout")

func get_value(arrow_idx: int):
	match type:
		Type.Block:
			return selected_object.position / 80
		Type.Line:
			return line.points[1] / 80
		Type.Mouse:
			return get_global_mouse_position() / 80

func _process(delta):
	match type:
		Type.Block:
			$Position.text = str(selected_object.position / 80)
		Type.Line:
			if line: $Position.text = str(line.points[1] / 80)
		Type.Mouse:
			$Position.text = str(get_global_mouse_position() / 80)

func set_line(val):
	line = val
	if type != Type.Line: return
	if get_node(val) == null:
		return
	line = get_node(val)
	if line:
		$Sprite.modulate = line.modulate 
		$Label.text = line.name
