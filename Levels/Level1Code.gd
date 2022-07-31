extends "res://Scripts/CodePicker.gd"

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				BUTTON_LEFT:
					if ($PointerL.position - get_local_mouse_position()).length() < 10:
						$PointerL.hide()
						$PointerR.show()
					elif $PointerL.visible == false and ($PointerR.position - get_local_mouse_position()).length() < 10:
						$PointerR.hide()
