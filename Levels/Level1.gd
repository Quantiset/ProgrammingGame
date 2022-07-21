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
		$CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level1Code/AnimationPlayer.play("End")
		yield($CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level1Code/AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(2), "timeout")
		Globals.set_level_complete(1)
		Globals.change_scene("res://Scenes/LevelSelect.tscn")

func _on_VideoPlayer_finished():
	$CanvasLayer/CenterContainer/VBoxContainer/VideoPlayer.play()
