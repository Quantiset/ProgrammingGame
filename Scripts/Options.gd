extends VSplitContainer

const SAVE_FILE := "user://options.save"
var save_dict := {}

func _ready():
	var f := File.new()
	f.open(SAVE_FILE, File.READ_WRITE)
	var data = f.get_var()
	f.close()
	if data:
		save_dict = data
	
	for button_name in save_dict:
		_on_CheckButton_toggled(save_dict[button_name], button_name)

func _on_CheckButton_toggled(button_pressed, button_name):
	var button = find_node(button_name + "Button")
	button.pressed = button_pressed
	match button_name:
		"VSync":
			OS.vsync_enabled = button_pressed
		"FPS":
			Globals.show_fps = button_pressed
	save_dict[button_name] = button_pressed
	save()

func save():
	var f := File.new()
	f.open(SAVE_FILE, f.WRITE_READ)
	f.store_var(save_dict)
	f.close()
