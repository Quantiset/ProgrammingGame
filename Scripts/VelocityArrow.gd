extends Line2D

export (NodePath) onready var target = get_node(target)

var last_pos := Vector2()

func _ready():
	pass
#	append_point(Vector2())
#	append_point(Vector2())
#	task_update_velocity()

func task_update_velocity():
	if target:
		remove_point(1)
		var vel: Vector2 = target.position - last_pos
		append_point(vel)
		last_pos = target.position
		target.velocity = vel
	
	yield(get_tree().create_timer(0.1), "timeout")
	task_update_velocity()

func append_point(val: Vector2):
	add_point(val)
	$Head.position = val
	$Head.rotation = val.angle()
