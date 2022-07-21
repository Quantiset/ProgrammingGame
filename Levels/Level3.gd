extends Main

func _process(delta):
	if $Block.position.is_equal_approx($Pointer.position):
		set_process(false)
		$CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level3Code/AnimationPlayer.play("end")
		yield($CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level3Code/AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(2), "timeout")
		Globals.set_level_complete(3)
		Globals.change_scene("res://Scenes/LevelSelect.tscn")
