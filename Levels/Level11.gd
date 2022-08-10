extends Main

var required_points := [
	Vector2(0.303771, 80.301956),
	Vector2(-12.5561, 63.167229),
	Vector2(-15.983232, 55.677277),
	Vector2(-18.6584, 46.775631),
	Vector2(-19.993017, 35.502075),
	Vector2(-18.680157, 23.121298),
	Vector2(-16.704557, 16.901028),
	Vector2(-6.025327, 2.603846),
	Vector2(-1.19752, 0.21121),
	Vector2(-0.788741, 0.112152),
	Vector2(-2.264826, -0.559256),
	Vector2(-4.36692, -1.555011),
	Vector2(-8.848705, -4.935145),
	Vector2(-12.27645, -8.86514)
]

var block_prev := Vector2()

func _physics_process(delta):
	if block_prev != $Block.position:
		$Line2D.add_point($Block.position)
		block_prev = $Block.position
		
		for point in required_points.duplicate():
			if ($Block.position - point).length_squared() < 0.15:
				required_points.erase(point)
		
		if required_points.size() == 2:
			yield(get_tree().create_timer(2), "timeout")
			set_level_complete(11)
	
