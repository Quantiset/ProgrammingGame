extends Main

func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed():
					$CanvasLayer/CenterContainer.hide()

func _on_VideoPlayer_finished():
	$CanvasLayer/CenterContainer/VBoxContainer/VideoPlayer.play()
