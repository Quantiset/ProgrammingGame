extends Main


func _process(delta):
	if $Block.position.is_equal_approx($Pointer.position):
		update_step()

var step := 0
func update_step():
	step += 1
	match step:
		0:
			$Pointer.position *= 2
		1:
			$Pointer.position *= -1
		2:
			$Pointer.position.x *= 0.5
			$Pointer.position.y *= -2
		3:
			set_process(false)
			$CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level8Code/AnimationPlayer.play("End")
			yield($CanvasLayer/HSplitContainer/MarginContainer/ViewportContainer/Viewport/Level8Code/AnimationPlayer, "animation_finished")
			yield(get_tree().create_timer(2), "timeout")
			set_level_complete(8)
