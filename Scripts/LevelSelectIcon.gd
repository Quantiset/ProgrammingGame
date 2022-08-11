extends CodeNode

onready var level: int = int(name.trim_prefix("LevelSelectIcon"))

func _ready():
	$Label.text = str(level)
	if Globals.levels.has(level):
		modulate = Globals.levels[level].color

func _on_LevelSelect_gui_input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.is_pressed():
					Globals.to_level(level)


func _on_LevelSelectIcon_mouse_entered():
	$Outline.show()
	#rect_scale *= 1.5
func _on_LevelSelectIcon_mouse_exited():
	$Outline.hide()
	#rect_scale /= 1.5

