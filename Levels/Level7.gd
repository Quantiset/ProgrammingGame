extends Main

var frames := 0

func _process(delta):
	if $Block.position.length() > 79 and $Block.position.length() < 81:
		frames += 1
		if frames == 200:
			Globals.set_level_complete(7)
			Globals.change_scene("res://Scenes/LevelSelect.tscn")
	else:
		frames = 0
