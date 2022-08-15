extends Main

func _ready():
	var steps = 200
	var step_ang = 2 * PI / steps
	
	for i in range(steps+1):
		var vec = Vector2(400, 0).rotated(step_ang * i)
		$Circle.add_point(vec)

func _process(delta):
	$X.remove_point(1)
	$Y.remove_point(1)
	
	var mouse_pos: Vector2 = $Green.points[1]
	
	$Label.rect_position = mouse_pos / 2 + Vector2(0, -50)
	$Label.text = "Length: " + str(stepify(mouse_pos.length() / 80, 0.1))
	
	$X.add_point(Vector2(mouse_pos.x,0))
	$Y.position.x = mouse_pos.x
	$Y.add_point(Vector2(0,mouse_pos.y))


func _on_NextLevel_activated():
	set_level_complete(14)
