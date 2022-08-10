extends Main

var iter := 0

func _process(delta):
	if $Block.position.is_equal_approx($Pointer.position):
		set_process(false)
		yield(get_tree().create_timer(1), "timeout")
		match iter:
			0, 1:
				$Pointer.position = $Pointer.position.rotated(-PI/2)
				set_process(true)
			2:
				$CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level10Code/AnimationPlayer.play("Condense")
				yield($CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level10Code/AnimationPlayer, "animation_finished")
				yield(get_tree().create_timer(2), "timeout")
				set_level_complete(10)
		iter += 1
