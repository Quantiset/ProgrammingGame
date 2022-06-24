extends CodeNode

var time := 0

func get_value(_arrow_idx: int):
	return OS.get_ticks_msec() / 1000.0

func _on_Time_timeout():
	time += 1
	$Label.text = "Time (%ss)" % str(time)
