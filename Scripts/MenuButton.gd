extends TextureButton


onready var og_pos = rect_position

func _on_StartButton_mouse_entered():
	$Tween.interpolate_property(self, "rect_position", rect_position, og_pos + Vector2(50,0), 0.3)
	$Tween.start()


func _on_StartButton_mouse_exited():
	$Tween.interpolate_property(self, "rect_position", rect_position, og_pos, 0.3)
	$Tween.start()


func button_pressed(button_name):
	match button_name:
		"Options":
			get_tree().change_scene("res://Scenes/Options.tscn")
		"Start":
			get_tree().change_scene("res://Scenes/LevelSelect.tscn")
		"Quit":
			get_tree().quit()


