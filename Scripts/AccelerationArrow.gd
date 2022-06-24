extends Line2D

export (NodePath) onready var target = get_node(target)

var last_vel := Vector2()

func _ready():
	append_point(Vector2())
	append_point(Vector2())
	task_update_acc()

func task_update_acc():
	if target:
		remove_point(1)
		append_point(target.velocity - last_vel)
		last_vel = target.velocity
	
	yield(get_tree().create_timer(0.1), "timeout")
	task_update_acc()

func append_point(val: Vector2):
	add_point(val)
	$Head.position = val
	$Head.rotation = val.angle()
