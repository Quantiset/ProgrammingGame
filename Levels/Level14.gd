extends Main

var time_in := 0.0

func _process(delta):
	if is_equal_approx($Green.points[1].angle(), $Red.points[1].angle()) and \
			$Red.points[1].length() < 81 and $Green.points[1].length() > 82 and \
			$Red.points[1].length() > 79:
		time_in += delta
		if time_in > 2:
			set_level_complete(14)
