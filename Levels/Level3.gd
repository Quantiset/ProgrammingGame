extends Main

func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed():
					$CanvasLayer/CenterContainer.hide()

func _process(delta):
	if $Block.position.is_equal_approx($Pointer.position):
		set_process(false)
		yield(get_tree().create_timer(1), "timeout")
		Globals.set_level_complete(3)
		Globals.change_scene("res://Scenes/LevelSelect.tscn")

