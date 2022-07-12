extends Line2D
tool

export (NodePath) onready var target = get_node_or_null(target if target is NodePath else "")

func _ready():
	if target:
		add_point(target.position)
	$Head.modulate = default_color

func _process(delta):
	if target:
		remove_point(1)
		add_point(target.position)

func add_point(val: Vector2, thing=2):
	.add_point(val)
	$Head.position = val
	$Head.rotation = val.angle()
