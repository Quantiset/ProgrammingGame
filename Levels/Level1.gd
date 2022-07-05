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
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")

func _on_VideoPlayer_finished():
	$CanvasLayer/CenterContainer/VBoxContainer/VideoPlayer.play()
