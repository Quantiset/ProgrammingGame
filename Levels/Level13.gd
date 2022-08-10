extends Main

var time_in := 0.0

func _process(delta):
	$White.remove_point(1)
	if time_in < 1:
		$White.add_point($Green.points[1] * -1)
	else:
		$White.add_point($Green.points[1].rotated(PI/2) * -0.5)
	if $Red.points[1].round().is_equal_approx($White.points[1].round()):
		time_in += delta
		if time_in > 2:
			set_level_complete(13)
