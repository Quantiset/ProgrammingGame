extends CodeNode

var time := 0.0

func _process(delta):
	time += delta

func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed() and $Button.get_global_rect().has_point(event.position):
					time = 0
					_on_Time_timeout()
					$Time.start(1)

func get_value(_arrow_idx: int):
	return time

func _on_Time_timeout():
	$Label.text = "Time | %ss" % str(round(time))


func _on_Button_pressed():
	get_tree().call_group("TimeNode", "reset_time")

func reset_time():
	time = 0
	_on_Time_timeout()
	$Time.start(1)
