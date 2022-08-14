extends Main

var required_points := [
	Vector2(-387.667542, -203.491455),
	Vector2(-381.562805, -215.121475),
	Vector2(-375.109192, -226.568359),
	Vector2(-368.312103, -237.82164),
	Vector2(-361.177429, -248.871002),
	Vector2(-353.711304, -259.706329),
	Vector2(-345.920135, -270.317657),
	Vector2(-337.810638, -280.695251),
	Vector2(-329.389771, -290.829559),
	Vector2(-320.664856, -300.711243),
	Vector2(-311.643524, -310.331177),
	Vector2(-302.333588, -319.680481),
	Vector2(-292.743164, -328.750488),
	Vector2(-282.880646, -337.532806),
	Vector2(-272.754669, -346.019226),
	Vector2(-262.374084, -354.201843),
	Vector2(-251.748032, -362.073059),
	Vector2(-240.885834, -369.625519),
	Vector2(-229.797058, -376.852081),
	Vector2(-218.491501, -383.746002),
	Vector2(-206.979126, -390.300751),
	Vector2(-195.270096, -396.510132),
	Vector2(-183.374786, -402.368225),
	Vector2(-171.303741, -407.869507),
	Vector2(-159.067673, -413.008606),
	Vector2(-146.677414, -417.78064),
	Vector2(-134.143997, -422.180969),
	Vector2(-121.478577, -426.205292),
	Vector2(-108.692413, -429.84967),
	Vector2(-95.796928, -433.110413),
	Vector2(-82.803612, -435.984344),
	Vector2(-69.724083, -438.468445),
	Vector2(-56.57003, -440.56015),
	Vector2(-43.353226, -442.257263),
	Vector2(-30.085506, -443.557861),
	Vector2(-16.77877, -444.460419),
	Vector2(-3.444959, -444.963745),
	Vector2(9.903954, -445.067108),
]

func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed():
					$CanvasLayer/CenterContainer.hide()


var block_prev := Vector2()
func _physics_process(delta):
	if block_prev != $Block.position:
		$Line2D.add_point($Block.position)
		if $Line2D.get_point_count() > 120:
			$Line2D.remove_point($Line2D.get_point_count()-1)
		block_prev = $Block.position
		
		for point in required_points.duplicate():
			if ($Block.position - point).length() < 30:
				required_points.erase(point)
		
		if randi() % 10 == 1:
			print(required_points)
		
		if required_points.size() <= 4:
			yield(get_tree().create_timer(2), "timeout")
			set_level_complete(16)

func _on_VideoPlayer_finished():
	$CanvasLayer/CenterContainer/VBoxContainer/VideoPlayer.play()
