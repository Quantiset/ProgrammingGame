extends Main

func _process(delta):
	if $Block.position.is_equal_approx($Pointer.position):
		set_process(false)
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")

