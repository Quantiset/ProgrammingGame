extends Main


func _process(delta):
	if ($Block.position - $Pointer.position).length() < 10:
		set_process(false)
		yield(get_tree().create_timer(1), "timeout")
		set_level_complete(9)
