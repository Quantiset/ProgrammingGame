extends Main


func _process(delta):
	if (($BBlock.position - $BPointer.position).length() < 10
	and ($GBlock.position - $GPointer.position).length() < 10):
		set_process(false)
		yield(get_tree().create_timer(1), "timeout")
		set_level_complete(12)
