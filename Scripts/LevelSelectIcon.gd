extends CodeNode


func _ready():
	$Label.text = name.trim_prefix("LevelSelectIcon")

func _on_LevelSelect_gui_input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed():
					pass
					var f := File.new()
					if f.file_exists("res://Levels/Level"+$Label.text+".tscn"):
						Globals.change_scene("res://Levels/Level"+$Label.text+".tscn")


func _on_LevelSelectIcon_mouse_entered():
	$Outline.show()
	#rect_scale *= 1.5
func _on_LevelSelectIcon_mouse_exited():
	$Outline.hide()
	#rect_scale /= 1.5

