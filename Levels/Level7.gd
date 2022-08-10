extends Main

var frames := 0

func _process(delta):
	if $Block.position.length() > 79 and $Block.position.length() < 81:
		frames += 1
		if frames == 200:
			set_level_complete(7)
	else:
		frames = 0
