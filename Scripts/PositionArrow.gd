extends Line2D

export (NodePath) onready var target = get_node(target)

func _ready():
	append_point(target.position)

func _process(delta):
	if target:
		remove_point(1)
		append_point(target.position)

func append_point(val: Vector2):
	add_point(val)
	$Head.position = val
	$Head.rotation = val.angle()
