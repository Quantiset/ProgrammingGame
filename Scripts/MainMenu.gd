extends VSplitContainer

var time := 0.0

func _process(delta):
	time += delta
	
	$Block.position = Vector2(1-cos(time), 0).rotated(time * 0.8) * 140 + Vector2(400, 560)
	$Line2D.add_point($Block.position)
	if $Line2D.get_point_count() > 2000:
		$Line2D.remove_point(0)
